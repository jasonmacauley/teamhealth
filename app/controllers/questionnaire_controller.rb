class QuestionnaireController < ApplicationController
  def index
    @questionnaires = Questionnaire.all
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def update
    @questionniare = Questionnaire.new
    unless params[:commit].match(/Create/)
      @questionniare = Questionnaire.find(params[:questionnaire][:id])
    end
    @questionniare.name = params[:questionnaire][:name]
    @questionniare.description = params[:questionnaire][:description]
    @questionniare.save
    redirect_to(show_questionnaire_path(@questionniare))
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  def delete
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.delete
    redirect_to(questionnaire_index_path)
  end
end
