class VolatilityTarget < BaseTarget
  NAME = 'Volatility'.freeze
  METHOD = 'calculated'.freeze
  LABEL = 'volatility'.freeze
  AGGREGATION_METHOD = 'average'.freeze

  def initialize
    @target_type = create_target_type
  end

  def generate(organization, metric_type, period_start, period_end)
    target = Target.where(target_type_id: @target_type.id,
                          name: target_name(metric_type),
                          organization_id: organization.id,
                          period_start: period_start,
                          period_end: period_end)[0]
    return target unless target.nil?

    target_value = volatility(metric_type, organization, period_start)
    target = Target.create(organization_id: organization.id,
                           target_type_id: @target_type.id,
                           name: target_name(metric_type),
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

  def volatility(metric_type, organization, period_start)
    metrics = organization.org_metrics_by_type(metric_type)
    data = {}
    metrics.each do |key, value|
      next unless key[1] <= period_start

      data[key[1]] = value
    end
    stats = data.keys.sort.last(2)
    values = []
    stats.map { |key| values.push(data[key]) }
    return 0 if values.count < 2

    dif = ((values[1].to_f - values[0]) / values[1]) * 100
    dif
  end

  def target_name(metric_type)
    metric_type.name + ' Volatility'
  end

  def create_target_type
    type = TargetType.where(name: NAME)[0]
    return type unless type.nil?

    type = TargetType.create(name: NAME, implementation: self.class.to_s)
    type
  end
end
