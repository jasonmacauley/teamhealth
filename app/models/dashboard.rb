class Dashboard < ApplicationRecord
  has_many :dashboard_widgets
  belongs_to :user
end
