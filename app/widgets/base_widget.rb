class BaseWidget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Widget'.freeze
  attr_reader :widget_type

  def initialize()
    @widget_type = nil
  end

  def get_widget(name)
    self.class.descendants.each do |type|
      return type.new if name == type::NAME
    end
  end

  def all_widgets
    widgets = []
    self.class.descendants.each do |type|
      widgets.push(type.new)
    end
    widgets
  end

  def generate(options)
    raise(NotImplementedError)
  end

  def name
    self.class::NAME
  end

  def int?(str)
    str.to_i.to_s == str
  end
end
