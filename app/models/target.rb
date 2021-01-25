class Target < ApplicationRecord
  belongs_to :target_type
  belongs_to :organization

  def type
    target_type
  end

  private

  def target_implementation
    target_type.implementation.constantize
  end
end
