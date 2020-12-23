class OrganizationTypeController < ApplicationController
  def index
    @org_types = OrganizationType.all
  end

  def show
    @org_type = OrganizationType.find(params[:id])
  end

  def edit
    @org_type = OrganizationType.find(params[:id])
  end

  def update
    @org_type = OrganizationType.new
    unless params[:commit].match(/Create/)
      @org_type = OrganizationType.find(params[:organization_type][:id])
    end
    @org_type.name = params[:organization_type][:name]
    @org_type.description = params[:organization_type][:description]
    @org_type.save
    redirect_to(organization_type_path(@org_type))
  end

  def new
    @org_type = OrganizationType.new
  end

  def delete
    OrganizationType.find(params[:id]).delete
    redirect_to(organization_type_index_path)
  end
end
