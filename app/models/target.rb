class Target < ApplicationRecord
  belongs_to :target_type
  belongs_to :organization

  def generate(organization, period_start, period_end)
    target_type = target_implementation.new
    target_type.generate(organization, period_start, period_end)
  end

  private

  def target_implementation
    target_type.implementation.constantize
  end
end
