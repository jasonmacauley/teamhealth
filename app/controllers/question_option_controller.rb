class QuestionOptionController < ApplicationController
  def new
    @question_option = QuestionOption.new
    @question = Question.find(params[:id])
    @questionnaire = @question.questionnaire
  end

  def edit
    @question_option = QuestionOption.find(params[:id])
    @question = @question_option.question
    @questionnaire = @question.questionnaire
  end

  def delete
    @question_option = QuestionOption.find(params[:id])
    @question = @question_option.question
    @question_option.delete
    redirect_to(show_questionnaire_path(@question.questionnaire))
  end

  def update
    @question_option = QuestionOption.new
    unless params[:commit].match(/Create/)
      @question_option = QuestionOption.find(params[:question_option][:id])
    end
    @question_option.text = params[:question_option][:text]
    @question_option.question_id = params[:question_option][:question_id]
    @question_option.value = params[:question_option][:value]
    @question_option.save
    redirect_to(show_questionnaire_path(@question_option.question.questionnaire))
  end
end
