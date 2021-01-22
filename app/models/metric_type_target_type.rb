class MetricTypeTargetType < ApplicationRecord
  belongs_to :target_type
  belongs_to :metric_type
end
