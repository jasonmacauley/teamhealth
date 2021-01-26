class OrganizationController < ApplicationController
  def index
    @orgs = Organization.all
  end

  def show
    @org = Organization.find(params[:id])
  end

  def edit
    @org = Organization.find(params[:id])
  end

  def update
    @org = Organization.new
    unless params[:commit].match(/Create/)
      @org = Organization.find(params[:organization][:id])
    end
    @org.name = params[:organization][:name]
    @org.organization_type_id = params[:organization][:organization_type_id]
    @org.organization_id = params[:organization][:organization_id]
    @org.save
    redirect_to(organization_path(@org))
  end

  def update_metric_types
    @org = Organization.find(params[:organization][:organization_id])
    metric_ids = params[:organization][:metric_type_ids]
    metric_ids.each do |id|
      next unless id.to_i.to_s == id
      next if @org.metric_type_ids.include? id.to_i

      @org.metric_types.push(MetricType.find(id))
    end
    types = @org.metric_types.select { |type| metric_ids.map{ |id| id.to_i }.include? type.id }
    @org.metric_types = types
    redirect_to(organization_path(@org))
  end

  def set_organization_metric_defaults
    @org = Organization.find(params[:organization][:organization_id])
    @org.metric_types.each do |metric|
      metric.target_types.select { |t| t.method =~ /manual/i }.each do |type|
        org_metric = OrganizationMetricType.where(metric_type_id: metric.id, organization_id: @org.id)[0]
        org_metric.value = params[:organization][org_metric.id.to_s.to_sym]
        org_metric.save
      end
    end
    redirect_to(organization_path(@org))
  end

  def new
    @org = Organization.new
  end

  def delete
  end
end
