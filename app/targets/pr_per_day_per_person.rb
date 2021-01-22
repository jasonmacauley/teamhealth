class PrPerDayPerPerson < BaseTarget
  NAME = 'PR Per Person Per Day Target'.freeze
  METHOD = 'calculated'.freeze
  LABEL = 'pr_per_person_per_day_target'.freeze

  def initialize
    @target_type = create_target_type
  end

  def generate(organization, period_start, period_end)
    target = Target.where(target_type_id: @target_type.id,
                          organization_id: organization.id,
                          period_start: period_start,
                          period_end: period_end)
    return target unless target.nil?

    days = (period_end - period_start).to_i
    target_value = organization.all_org_members.count * days
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
