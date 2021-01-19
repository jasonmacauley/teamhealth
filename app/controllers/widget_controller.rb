class WidgetController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
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
    @widget.widget_configs = []
    @widget_type.dashboard_widget_config_types.each do |config_type|
      values = Array(params[:widget][config_type.label.to_sym])
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
