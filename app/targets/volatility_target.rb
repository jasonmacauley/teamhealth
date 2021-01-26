class VolatilityTarget < BaseTarget
  NAME = 'Volatility'.freeze
  METHOD = 'calculated'.freeze
  LABEL = 'volatility'.freeze
  AGGREGATION_METHOD = 'average'.freeze

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

    target_value = volatility(metric)
    target = Target.create(organization_id: organization.id,
                           target_type_id: @target_type.id,
                           name: target_name(metric),
                           period_start: period_start,
                           period_end: period_end,
                           value: target_value)
    target
  end

  def aggregate(values)
    aggregate_by_average(values)
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

  def volatility(metric)
    metrics = Metric.order(period_start: :asc).select(:value)
                    .where(['metric_type_id = ? AND organization_id = ? AND period_end < ?',
                            metric.metric_type.id, metric.organization.id, metric.period_start])
    return 0 if metrics.empty?
    metrics.last.value - metric.value
  end

  def target_name(metric)
    metric.metric_type.name + ' Trailing Average'
  end

  def create_target_type
    type = TargetType.where(name: NAME)[0]
    return type unless type.nil?

    type = TargetType.create(name: NAME, implementation: self.class.to_s)
    type
  end
end
