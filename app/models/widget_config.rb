class WidgetConfig < ApplicationRecord
  belongs_to :widget
  belongs_to :dashboard_widget_config_type
end
