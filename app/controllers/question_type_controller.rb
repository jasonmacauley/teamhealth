class QuestionTypeController < ApplicationController
  def index
    @question_types = QuestionType.all
  end

  def show
    @question_type = QuestionType.find(params[:id])
  end

  def update
    @question_type = QuestionType.new
    unless params[:commit].match(/Create/)
      @question_type = QuestionType.find(params[:question_type][:id])
    end
    @question_type.name = params[:question_type][:name]
    @question_type.save
    redirect_to(question_type_index_path)
  end

  def new
    @question_type = QuestionType.new
  end

  def edit
    @question_type = QuestionType.find(params[:id])
  end

  def delete
    @question_type = QuestionType.find(params[:id])
    @question_type.delete
    redirect_to(question_type_index_path)
  end
end
