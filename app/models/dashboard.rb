class Dashboard < ApplicationRecord
  has_many :dashboard_widgets
  has_many :widgets, through: :dashboard_widgets
  belongs_to :user
end
