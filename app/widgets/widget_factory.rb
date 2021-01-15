class WidgetFactory
  include Singleton
  def get_widget(widget)
    options = {}
    widget.widget_configs.each do |conf|
      options[conf.dashboard_widget_config_type.label] = [] if options[conf.dashboard_widget_config_type.label].nil?
      options[conf.dashboard_widget_config_type.label].push(conf.value)
    end
    @widget_hash[widget.widget_type.name].generate(options)
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

  private

  def load_widgets
    Dir.chdir("#{Rails.root}/app/widgets/")
    Dir.glob('*.rb').each do |file|
      require file.split('.')[0]
    end

  end
end
