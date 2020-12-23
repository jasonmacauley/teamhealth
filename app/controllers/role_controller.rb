class RoleController < ApplicationController
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
    render :'role/new'
  end

  def update
    @role = Role.new
    unless params[:commit].match(/Create\sRole/)
      @role = Role.find(params[:role][:id])
    end
    @role.name = params[:role][:name]
    @role.description = params[:role][:description]
    @role.save
    redirect_to(role_path(@role))
  end

  def delete
    @role = Role.find(params[:id]).delete
    redirect_to(role_index_path)
  end

  # </editor-fold>
  def new
    @role = Role.new
  end
end
