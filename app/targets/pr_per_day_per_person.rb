class PrPerDayPerPerson < BaseTarget
  NAME = 'PR Per Person Per Day Target'.freeze
  METHOD = 'calculated'.freeze
  LABEL = 'pr_per_person_per_day_target'.freeze
  AGGREGATION_METHOD = 'sum'.freeze

  def initialize
    @target_type = create_target_type
  end

  def generate(organization, metric, period_start, period_end)
    target = Target.where(target_type_id: @target_type.id,
                          name: target_name(metric),
                          organization_id: organization.id,
                          period_start: period_start,
                          period_end: period_end)[0]
    return target unless target.nil?

    target_value = organization.all_org_members.count * business_days_between(period_start, period_end)
    target = Target.create(organization_id: organization.id,
                           target_type_id: @target_type.id,
                           name: target_name(metric),
                           period_start: period_start,
                           period_end: period_end,
                           value: target_value)
    target
  end

  def aggregate(values)
    aggregate_by_sum(values)
  end


  def aggregation_method
    AGGREGATION_METHOD
  end


  private

  def business_days_between(date1, date2)
    business_days = 0
    date = date2
    while date >= date1
      business_days = business_days + 1 unless date.saturday? || date.sunday?
      date = date - 1.day
    end
    business_days
  end

  def target_name(metric)
    metric.metric_type.name + ' Static Target'
  end
end
