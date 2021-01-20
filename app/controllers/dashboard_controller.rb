class DashboardController < ApplicationController
  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    redirect_to(dashboard_index_path) if @dashboard.private && @dashboard.user_id != current_user.id
  end

  def add_widget
    @dashboard = Dashboard.find(params[:dashboard][:id])
    widget = Widget.find(params[:dashboard][:widget_id])
    @dashboard.widgets.push(widget)
    redirect_to(show_dashboard_path(@dashboard))
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  def update
    @dashboard = Dashboard.new
    unless params[:commit].match(/Create/)
      @dashboard = Dashboard.find(params[:dashboard][:id])
    end
    @dashboard.name = params[:dashboard][:name]
    @dashboard.description = params[:dashboard][:description]
    @dashboard.user_id = current_user.id
    @dashboard.private = false
    @dashboard.private = true if params[:dashboard][:private] == "1"
    @dashboard.save
    redirect_to(show_dashboard_path(@dashboard))
  end

  def generate_organization_dashboards
    org = Organization.find(params[:organization_id])
    template_dashboard = Dashboard.find(params[:dashboard_id])
    build_org_dashboard(org, template_dashboard)
    redirect_to(dashboard_index_path)
  end

  def delete
    @dashboard = Dashboard.find(params[:id])
    @dashboard.delete
    redirect_to(dashboard_index_path)
  end

  private

  def build_org_dashboard(org, template_dashboard)
    json = template_dashboard.as_json(except: :id)
    dashboard = Dashboard.new(json)
    dashboard.name = org.name + ' Health Dashboard'
    dashboard.private = false
    dashboard.save
    build_org_widgets(org, template_dashboard, dashboard)
    org.organizations.each do |sub_org|
      build_org_dashboard(sub_org, template_dashboard)
    end
  end

  def build_org_widgets(org, template_dashboard, new_dashboard)
    template_dashboard.widgets.each do |template_widget|
      json = template_widget.as_json(except: :id)
      widget = Widget.new(json)
      widget.name = org.name + ' ' + widget.widget_type.name
      widget.save
      new_dashboard.widgets.push(widget)
      build_widget_config(org, template_widget, widget)
    end
  end

  def build_widget_config(org, template_widget, widget)
    org_type = DashboardWidgetConfigType.find_by_name('organization')
    template_widget.widget_configs.each do |template_config|
      config_json = template_config.as_json(except: :id)
      widget_config = WidgetConfig.new(config_json)
      widget_config.widget_id = widget.id
      widget_config.value = org.id if widget_config.dashboard_widget_config_type.id == org_type.id
      widget_config.save
    end
  end
end
