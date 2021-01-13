class DashboardWidgetConfig < ApplicationRecord
  belongs_to :dashboard_widget
  belongs_to :dashboard_widget_config_type
end
