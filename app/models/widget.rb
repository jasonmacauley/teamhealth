class Widget < ApplicationRecord
  belongs_to :widget_type
  has_many :dashboard_widgets
  has_many :widget_configs

  def generate
    options = {}
    self.widget_configs.each do |conf|
      options[conf.dashboard_widget_config_type.label] = [] if options[conf.dashboard_widget_config_type.label].nil?
      options[conf.dashboard_widget_config_type.label].push(conf.value)
    end
    WidgetFactory.instance.get_widget(self).generate(options)
  end
end
