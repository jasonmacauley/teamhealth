class DashboardWidgetConfigType < ApplicationRecord
  has_many :dashboard_widget_configs
  has_many :widget_config_types
end
