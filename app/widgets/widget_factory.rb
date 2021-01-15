class WidgetFactory
  include Singleton
  def get_widget(name)
    @widget_hash[name]
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
