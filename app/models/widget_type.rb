class WidgetType < ApplicationRecord
  has_many :widgets
  has_many :widget_config_types
end
