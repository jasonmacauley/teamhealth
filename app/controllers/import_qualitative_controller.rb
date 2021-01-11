class ImportQualitativeController < ApplicationController
  def import
    @questionnaire = Questionnaire.find(params[:questionnaire][:id])
    question_hash = {}
    @questionnaire.questions.each do |q|
      question_hash[params[:questionnaire][q.label.to_sym]] = q
    end
    file = params[:questionnaire][:file]
    CSV.foreach(file.path, headers: true) do |row|
      handle_row(question_hash, row)
    end
    redirect_to(show_questionnaire_path(@questionnaire))
  end

  def index
    @questionnaire = Questionnaire.find(params[:id])
  end

  private

  def handle_row(question_hash, row)
    team_member = find_or_create_team_member(row[params[:questionnaire][:user].to_i],
                                             row[params[:questionnaire][:team].to_i],
                                             row[params[:questionnaire][:title].to_i])
    question_hash.each do |key, question|
      response = Response.new
      response.team_member_id = team_member.id
      response.question_id = question.id
      response.value = row[key.to_i]
      response.save
    end
  end

  def find_or_create_team_member(email, team, title)
    member = find_member_by_email(email)
    return member unless member.nil?

    member = TeamMember.new if member.nil?
    set_name_from_email(email, member)
    set_title(member, title)
    guess_location_by_email(email, member)
    set_user(email, member)
    member.save
    add_member_to_team(member, team)
    member
  end

  def add_member_to_team(member, team)
    team = Organization.find_by_name(team)
    team.team_members.push(member)
    team.save
  end

  def set_user(email, member)
    User.new(email: email, password: SecureRandom.hex).save if member.user.nil?
    member.user = User.find_by_email(email)
  end

  def guess_location_by_email(email, member)
    location = 'boston'
    location = 'london' if email =~ /co.uk/
    member.location = Location.find_by_name(location)
  end

  def set_title(member, title)
    title = 'none' if title =~ /\#N/
    member.title = Title.find_by_name(title)
    member.title = Title.create(name: title) if member.title.nil?
  end

  def set_name_from_email(email, member)
    email_split = email.split('@')
    name_split = email_split[0].split('.')
    member.first_name = name_split[0].capitalize
    member.last_name = name_split[1].capitalize
  end

  def find_member_by_email(email)
    user = User.find_by_email(email)
    return nil if user.nil?

    TeamMember.find_by_user_id(user.id)
  end
end
