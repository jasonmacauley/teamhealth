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
    options['widget'] = self
    WidgetFactory.instance.get_widget(self).generate(options)
  end

  def get_configs_by_type_name(name)
    widget_configs.select { |c| c.dashboard_widget_config_type.name =~ /#{name}/i }
  end

  def get_series_type(metric, series)
    config = get_configs_by_type_name('Series Type')[0]
    config_data = JSON.parse config.value
    config_data[metric][series]
  end
end
