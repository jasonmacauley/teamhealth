class DashboardWidget < ApplicationRecord
  belongs_to :widget
  belongs_to :dashboard
  has_many :dashboard_widget_configs
end
