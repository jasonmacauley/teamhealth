class MetricsController < ApplicationController
  def add
    @team = Organization.find(params[:id])
    @metrics = MetricType.where(label: 'manual')
  end

  def update
    @metrics = MetricType.where(label: 'manual')
    @team = Organization.find(params[:team_id])
    month = Date::MONTHNAMES.index(params[:month])
    period_start = Date.new(Date.current.year, month, 1)
    period_end = Date.new(Date.current.year, month, -1)
    @metrics.each do |metric|
      create_metric(metric, params[metric.name.to_sym], @team.id, period_end, period_start)
    end
    redirect_to(organization_path(@team))
  end

  def import
    file = params[:file]
    throughput_type = MetricType.find_by_name("throughput")
    efficiency_type = MetricType.find_by_name("efficiency")
    success_rate_type = MetricType.find_by_name("pr success rate")
    throughput_target_type = MetricType.find_by_name("throughput target")
    success_rate_target_type = MetricType.find_by_name("success rate target")

    CSV.foreach(file.path, headers: true) do |row|
      date_str = row[0].split('/')
      m = date_str[0].to_i
      y = 2000 + date_str[1].to_i
      period_start = Date.new(y, m, 1)
      period_end = Date.new(y, m, -1)
      team = Organization.find_by_name(row[1])
      create_metric(efficiency_type, row[3], team.id, period_end, period_start)
      create_metric(success_rate_type, row[4], team.id, period_end, period_start)
      create_metric(throughput_type, row[5], team.id, period_end, period_start)
      create_metric(throughput_target_type, row[6], team.id, period_end, period_start)
      create_metric(success_rate_target_type, 80, team.id, period_end, period_start)
    end
    redirect_to(organization_path(Organization.find_by_name("SimplyBusiness")))
  end

  def delete
    @metric = Metric.find(params[:id])
    @team = @metric.organization
    @metric.delete
    redirect_to(organization_path(@team))
  end

  private

  def create_metric(metric, value, team_id, period_end, period_start)
    return if Metric.where(period_start: period_start, metric_type_id: metric.id, organization_id: team_id).size > 0
    Metric.create(organization_id: team_id,
                  metric_type_id: metric.id,
                  value: value,
                  period_start: period_start,
                  period_end: period_end)
  end
end
