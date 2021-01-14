class WidgetFactory
  include Singleton
  def get_widget(name)
    @widget_hash[name]
  end

  private

  def initialize
    @base_widget = BaseWidget.new
    @widget_hash = {}
    @base_widget.all_widgets.each do |widget|
      @widget_hash[widget.name] = widget
    end
  end
end
