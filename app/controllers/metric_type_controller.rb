class MetricTypeController < ApplicationController
  def index
    @metric_types = MetricType.all
  end

  def show
    @metric_type = MetricType.find(params[:id])
  end

  def edit
    @metric_type = MetricType.find(params[:id])
  end

  def new
    @metric_type = MetricType.new
  end

  def update
    @metric_type = MetricType.new
    unless params[:commit].match(/Create/)
      @metric_type = MetricType.find(params[:metric_type][:id])
    end
    @metric_type.name = params[:metric_type][:name]
    @metric_type.description = params[:metric_type][:description]
    @metric_type.label = params[:metric_type][:label]
    @metric_type.save
    redirect_to(metric_type_index_path)
  end

  def delete
    @metric_type = MetricType.find(params[:id])
    @metric_type.delete
    redirect_to(metric_type_index_path)
  end
end
