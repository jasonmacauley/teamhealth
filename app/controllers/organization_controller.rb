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
    @org.organization_type = OrganizationType.find(params[:organization][:organization_type])
    Organization.find(params[:organization][:organization_id]).organizations.push(@org)
    @org.save
    redirect_to(organization_path(@org))
  end

  def new
    @org = Organization.new
  end

  def delete
  end
end
