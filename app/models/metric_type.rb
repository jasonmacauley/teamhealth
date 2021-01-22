class MetricType < ApplicationRecord
  has_many :metrics
  has_many :metric_type_target_types
  has_many :target_types, through: :metric_type_target_types
  has_many :organization_metric_types
  has_many :organizations, through: :organization_metric_types
end
