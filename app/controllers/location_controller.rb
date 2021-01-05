class LocationController < ApplicationController
  def index
    @locations = Location.all
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.new
    unless params[:commit].match(/Create/)
      @location = Location.find(params[:location][:id])
    end
    @location.name = params[:location][:name]
    @location.save
    redirect_to(location_index_path)
  end

  def new
    @location = Location.new
  end

  def delete
    Location.find(params[:id]).delete
    redirect_to(location_index_path)
  end
end
