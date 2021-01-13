class Widget < ApplicationRecord
  belongs_to :widget_type
  has_many :dashboard_widgets
end
