class WidgetController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
    @config = []
    @widget.widget_configs.each do |conf|
      next if conf.value.empty?

      if conf.dashboard_widget_config_type.name =~ /metric/i
        type = MetricType.find(conf.value)
        targets = []
        type.target_types.map { |t| targets.push(t.name) }
        @config.push([conf.dashboard_widget_config_type.name, type.name, targets])
      elsif conf.dashboard_widget_config_type.name =~ /org/i
        @config.push([conf.dashboard_widget_config_type.name, Organization.find(conf.value).name, []])
      elsif conf.dashboard_widget_config_type.name =~ /quest/i
        @config.push([conf.dashboard_widget_config_type.name, Questionnaire.find(conf.value).name, []])
      else
        @config.push([conf.dashboard_widget_config_type.name, conf.value, []])
      end
    end
    @metric_types = {}
    @widget.get_configs_by_type_name('metrics').each do |metric|
      next if metric.value.to_i == 0

      type = MetricType.find(metric.value.to_i)
      series_type = @widget.get_series_type(type.name, type.name)
      @metric_types[type.name] = { 'type' => type,
                                   'series_type' => series_type,
                                   'targets' => []}
      targets = Target.select(:name, :target_type_id).where('target_type_id in (?)', type.target_type_ids).distinct.pluck(:name, :target_type_id)
      type.target_types.each do |target_type|
        target = targets.select { |t| t[1] == target_type.id }
        target = target.reject { |t| t[0] !~ /#{type.name}/i }
        target = target[0]
        next if target.nil?
        @metric_types[type.name]['targets'].push({ 'target' => target[0],
                                                   'series_type' => @widget.get_series_type(type.name, target[0]),
                                                   'targets' => {} })
      end
    end
    @chart_type = @widget.get_configs_by_type_name('chart type')[0]
  end

  def new
    @widget = Widget.new
    @widget_type = WidgetType.find(params[:id])
    @configs = widget_configs
  end

  def edit
    @widget = Widget.find(params[:id])
    @widget_type = @widget.widget_type
    @configs = widget_configs
  end

  def update
    @widget = Widget.new
    unless params[:commit].match(/Create/)
      @widget = Widget.find(params[:widget][:id])
    end
    @widget_type = WidgetType.find(params[:widget][:widget_type_id])
    @widget.name = params[:widget][:name]
    @widget.description = params[:widget][:description]
    @widget.widget_type_id = @widget_type.id
    @widget.save
    @widget_type.dashboard_widget_config_types.each do |config_type|
      input = params[:widget][config_type.label.to_sym]
      next if input.empty?

      values = Array(input)
      configs = WidgetConfig.where(dashboard_widget_config_type_id: config_type.id, widget_id: @widget.id)
      configs.each do |config|
        value = values.shift
        if value.nil?
          config.delete
          next
        end
        config.value = value
        config.save
      end
      values.each do |value|
        WidgetConfig.create(dashboard_widget_config_type_id: config_type.id, widget_id: @widget.id, value: value)
      end
    end
    redirect_to(show_widget_path(@widget))
  end

  def delete
    @widget = Widget.find(params[:id])
    @widget.delete
    redirect_to(widget_index_path)
  end

  def preview
    @widget = Widget.find(params[:id])
  end

  def combo_chart_config
    @widget = Widget.find(params[:widget][:id])
    @configs = @widget.get_configs_by_type_name('metrics').reject { |c| c.value.to_i == 0 }
    chart_config = {}
    @configs.each do |config|
      type = MetricType.find(config.value.to_i)
      chart_config[type.name] = {}
      params_keys = params[:widget].keys.select { |k| k =~ /^#{type.name}/i }
      params_keys.each do |key|
        value = params[:widget][key.to_sym]
        split_key = key.split('_')
        if split_key.count == 1
          chart_config[type.name][split_key[0]] = value
          next
        end
        chart_config[type.name][split_key[1]] = value
      end
    end
    json = chart_config.to_json
    series_type_conf = @widget.get_configs_by_type_name('Series Type')[0]
    series_type_conf = WidgetConfig.new if series_type_conf.nil?
    series_type_conf.value = json
    series_type_conf.widget_id = @widget.id
    series_type_conf.dashboard_widget_config_type = DashboardWidgetConfigType.find_by_name('Series Type')
    series_type_conf.save
    redirect_to(show_widget_path(@widget))
  end

  private

  def widget_configs
    configs = {}
    @widget_type.dashboard_widget_config_types.each do |type|
      confs = @widget.widget_configs.select { |c| c.dashboard_widget_config_type_id == type.id }
      unless confs.empty?
        confs.each do |c|
          configs[type.label] = { 'value' => [], 'type' => type } if configs[type.label].nil?
          configs[type.label]['value'].push(c.value)
        end
        next
      end
      conf = WidgetConfig.new
      conf.dashboard_widget_config_type = type
      conf.widget_id = @widget.id
      configs[type.label] = { 'value' => nil, 'type' => type }
    end
    configs
  end
end
