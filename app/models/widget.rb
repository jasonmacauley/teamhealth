class Widget < ApplicationRecord
  belongs_to :widget_type
  has_many :dashboard_widgets
  has_many :widget_configs
end
