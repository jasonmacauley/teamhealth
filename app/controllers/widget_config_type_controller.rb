class WidgetConfigTypeController < ApplicationController
  def index
    @config_types = DashboardWidgetConfigType.all
  end

  def show
    @config_type = DashboardWidgetConfigType.find(params[:id])
  end

  def edit
    @config_type = DashboardWidgetConfigType.find(params[:id])
  end

  def new
    @config_type = DashboardWidgetConfigType.new
  end

  def update
    @config_type = DashboardWidgetConfigType.new
    unless params[:commit].match(/Create/)
      @config_type = DashboardWidgetConfigType.find(params[:dashboard_widget_config_type][:id])
    end
    @config_type.name = params[:dashboard_widget_config_type][:name]
    @config_type.description = params[:dashboard_widget_config_type][:description]
    @config_type.save
    redirect_to(show_widget_config_type_path(@config_type))
  end

  def delete
    @config_type = DashboardWidgetConfigType.find(params[:id])
    @config_type.delete
    redirect_to(widget_type_index_path)
  end
end
