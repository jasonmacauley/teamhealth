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

  private

  def target_implementation
    String.new(implementation).constantize
  end
end
