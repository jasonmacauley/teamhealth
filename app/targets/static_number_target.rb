class StaticNumberTarget < BaseTarget
  NAME = 'Static Number Target'.freeze
  METHOD = 'manual'.freeze
  LABEL = 'static_number_target'.freeze
  AGGREGATION_METHOD = 'average'.freeze

  def initialize
    @target_type = create_target_type
  end

  def generate(organization, metric, period_start, period_end)
    target = Target.where(target_type_id: @target_type.id,
                          organization_id: organization.id,
                          name: target_name(metric),
                          period_start: period_start,
                          period_end: period_end)[0]
    return target unless target.nil?

    target_value = 100
    org_metric = OrganizationMetricType.where(metric_type_id: metric.metric_type.id,
                                              organization_id: organization.id)[0]
    target_value = org_metric.value unless org_metric.nil?
    target = Target.create(organization_id: organization.id,
                           target_type_id: @target_type.id,
                           name: target_name(metric),
                           period_start: period_start,
                           period_end: period_end,
                           value: target_value)
    target
  end


  def aggregation_method
    AGGREGATION_METHOD
  end


  def aggregate(values)
    aggregate_by_average(values)
  end
end
