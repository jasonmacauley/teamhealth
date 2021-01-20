class WidgetFactory
  include Singleton
  def get_widget(widget)
    @widget_hash[widget.widget_type.name]
  end

  private

  def initialize
    load_widgets
    @base_widget = BaseWidget.new
    @widget_hash = {}
    @base_widget.all_widgets.each do |widget|
      @widget_hash[widget.name] = widget
    end
  end

  def create_widget(options)
    widget = Widget.new
    widget_type = WidgetType.find(options[:widget_type_id])
    widget.name = options[:name]
    widget.description = options[:description]
    widget.widget_type_id = widget_type.id
    widget.save
    widget.widget_configs = []
    widget_type.dashboard_widget_config_types.each do |config_type|
      values = Array(options[config_type.label.to_sym])
      values.each do |value|
        WidgetConfig.create(dashboard_widget_config_type_id: config_type.id,
                            widget_id: widget.id,
                            value: value)
      end
    end
  end

  private

  def load_widgets
    Dir.chdir("#{Rails.root}/app/widgets/")
    Dir.glob('*.rb').each do |file|
      require file.split('.')[0]
    end

  end
end
