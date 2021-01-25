class TargetType < ApplicationRecord
  has_many :targets
  has_many :metric_type_target_types
  has_many :metric_types, through: :metric_type_target_types

  def method
    target_implementation::METHOD
  end

  def label
    target_implementation::LABEL
  end

  def generate(organization, metric, period_start, period_end)
    target_type = target_implementation.new
    target_type.generate(organization, metric, period_start, period_end)
  end

  def aggregate(values)
    target_type = target_implementation.new
    target_type.aggregate(values)
  end

  def aggregation_method
    target_type = target_implementation.new
    target_type.aggregation_method
  end

  def type
    self
  end

  private

  def target_implementation
    String.new(implementation).constantize
  end
end
