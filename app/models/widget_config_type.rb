class WidgetConfigType < ApplicationRecord
  belongs_to :widget_type
  belongs_to :dashboard_widget_config_type
end
