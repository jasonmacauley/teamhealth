class DashboardController < ApplicationController
  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    redirect_to(dashboard_index_path) if @dashboard.private && @dashboard.user_id != current_user.id

    widget = WidgetFactory.instance.get_widget('Team Qualitative Chart')
    options = { 'organization_id' => 903,
                'questionnaire_id' => 4 }
    @chart = widget.generate(options)
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

  def delete
    @dashboard = Dashboard.find(params[:id])
    @dashboard.delete
  end
end
