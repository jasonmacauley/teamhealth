module Widgets
  class BaseWidget
    extend ActiveSupport::DescendantsTracker
    NAME = 'Base Widget'.freeze
  end

  def get_widget(name)
    self.class.descendants.each do |type|
      return type.new if name == type::NAME
    end
  end

  def all
    widges = []
    self.class.descendants.each do |type|
      puts type::NAME
      widgets.push(type.new)
    end
  end
end
