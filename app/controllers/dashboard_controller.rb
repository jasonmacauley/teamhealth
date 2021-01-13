class DashboardController < ApplicationController
  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    redirect_to(dashboard_index_path) if @dashboard.private && @dashboard.user_id != current_user.id
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'foo')
    data_table.new_column('number', 'bar')
    data_table.add_rows([
        ['2020', 1000, 200],
        ['2021', 500, 500],
        ['2019', 2000, 700]])
    option = { width: 400, height: 240, title: 'Stuff' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
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
