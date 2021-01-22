class StaticNumberTarget < BaseTarget
  NAME = 'Static Number Target'.freeze
  METHOD = 'manual'.freeze
  LABEL = 'static_number_target'.freeze

  def initialize
    @target_type = create_target_type
  end

  def generate(organization, period_start, period_end)
    target = Target.where(target_type_id: @target_type.id,
                          organization_id: organization.id,
                          period_start: period_start,
                          period_end: period_end)
    return target unless target.nil?

    target_value = 100
    target = Target.create(organization_id: organization.id,
                           target_type_id: @target_type.id,
                           period_start: period_start,
                           period_end: period_end,
                           value: target_value)
    target
  end

  private

  def create_target_type
    type = TargetType.find_by_name(NAME)
    return type unless type.nil?

    type = TargetType.create(name: NAME, implementation: self.class.to_s)
    type
  end
end
