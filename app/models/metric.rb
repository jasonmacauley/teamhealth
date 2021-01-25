class Metric < ApplicationRecord
  belongs_to :metric_type
  belongs_to :organization
  has_many :metric_type_target_types, through: :metric_type
  has_many :target_types, through: :metric_type
  has_many :targets, through: :target_types

  def type
    metric_type
  end
end
