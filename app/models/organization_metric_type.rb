class OrganizationMetricType < ApplicationRecord
  belongs_to :metric_type
  belongs_to :organization
end
