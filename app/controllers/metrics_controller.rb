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
      Metric.create(organization_id: @team.id,
                    metric_type_id: metric.id,
                    value: params[metric.name.to_sym],
                    period_start: period_start,
                    period_end: period_end)
    end
    redirect_to(organization_path(@team))
  end

  def delete
    @metric = Metric.find(params[:id])
    @team = @metric.organization
    @metric.delete
    redirect_to(organization_path(@team))
  end
end
