class WidgetType < ApplicationRecord
  has_many :widgets
  has_many :widget_config_types
  has_many :dashboard_widget_config_types, through: :widget_config_types
end
