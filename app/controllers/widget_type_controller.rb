class WidgetTypeController < ApplicationController
  def index
    @widget_types = WidgetType.all
  end

  def show
    @widget_type = WidgetType.find(params[:id])
  end

  def edit
    @widget_type = WidgetType.find(params[:id])
  end

  def new
    @widget_type = WidgetType.new
  end

  def update
    @widget_type = WidgetType.new
    unless params[:commit].match(/Create/)
      @widget_type = WidgetType.find(params[:widget_type][:id])
    end
    @widget_type.name = params[:widget_type][:name]
    @widget_type.description = params[:widget_type][:description]
    @widget_type.partial = params[:widget_type][:partial]
    types = []
    params[:widget_type][:dashboard_widget_config_type_ids].each do |type_id|
      next if type_id !~ /\d+/
      types.push(DashboardWidgetConfigType.find(type_id.to_i))
    end
    @widget_type.dashboard_widget_config_types = types
    @widget_type.save
    redirect_to(show_widget_type_path(@widget_type))
  end

  def delete
    @widget_type = WidgetType.find(params[:id])
    @widget_type.delete
    redirect_to(widget_type_index_path)
  end
end
