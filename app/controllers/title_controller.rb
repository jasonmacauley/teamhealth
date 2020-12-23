class TitleController < ApplicationController
  def index
    @titles = Title.all
  end

  def show
    @title = Title.find(params[:id])
  end

  def edit
    @title = Title.find(params[:id])
  end

  def new
    @title = Title.new
  end

  def update
    @title = Title.new
    unless params[:commit].match(/Create/)
      @title = Title.find(params[:title][:id])
    end
    @title.name = params[:title][:name]
    @title.save
    redirect_to(title_index_path)
  end

  def delete
    Title.find(params[:id]).delete
    redirect_to(title_index_path)
  end
end
