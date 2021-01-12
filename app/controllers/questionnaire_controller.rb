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

  def display
    @questionnaire = Questionnaire.find(params[:id])
    @target_month = target_month
  end

  def collect
    @questionnaire = Questionnaire.find(params[:id])
    month = params[:period]
    year = Date.current.year
    year = year - 1 if month > Date.current.month
    period_start = Date.new(year, month, 1)
    period_end = Date.new(year, month, -1)

    @questionnaire.questions.each do |q|
      response = Response.create(team_member_id: current_user.id,
                                 question_id: q.id,
                                 value: params[:questionnaire][q.label.to_sym],
                                 period_start: period_start,
                                 period_end: period_end)
      response.save
    end
    redirect_to(response_thanks_url(@questionnaire))
  end

  def thanks
    @questionnaire = Questionnaire.find(params[:id])
  end

  def clone_question
    @question = Question.find(params[:id])
    @question_clone = clone_q(@question, @question.questionnaire_id)
    redirect_to(edit_question_path(@question_clone))
  end

  def clone_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire_clone = Questionnaire.create(name: @questionnaire.name,
                                                description: @questionnaire.description)
    @questionnaire.questions.each do |question|
      clone_q(question, @questionnaire_clone.id)
    end
    redirect_to(edit_questionnaire_path(@questionnaire_clone))
  end

  private

  def target_month
    target_month = Date.current.month
    target_month = (Date.current - 1.month).month if Date.current.day < 15
    target_month
  end

  def clone_q(question, questionnaire_id)
    question_clone = Question.create(text: question.text,
                                     question_type_id: question.question_type_id,
                                     questionnaire_id: questionnaire_id,
                                     label: question.label)
    clone_options(question, question_clone)
    question_clone
  end

  def clone_options(question, question_clone)
    question.question_options.each do |option|
      QuestionOption.create(text: option.text,
                            question_id: question_clone.id,
                            value: option.value,
                            label: option.label)
    end

  end
end
