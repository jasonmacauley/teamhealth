class QuestionController < ApplicationController
  def new
    @question = Question.new
    @questionnaire = Questionnaire.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    @questionnaire = @question.questionnaire
  end

  def delete
    @question = Question.find(params[:id])
    @questionnaire = @question.questionnaire
    @question.delete
    redirect_to(show_questionnaire_path(@questionnaire))
  end

  def update
    @question = Question.new
    unless params[:commit].match(/Create/)
      @question = Question.find(params[:question][:id])
    end
    @question.text = params[:question][:text]
    @question.questionnaire_id = params[:question][:questionnaire_id]
    @question.question_type_id = params[:question][:question_type]
    @question.save
    redirect_to(show_questionnaire_path(@question.questionnaire))
  end
end
