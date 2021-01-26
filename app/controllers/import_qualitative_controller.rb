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
    month = row[params[:questionnaire][:month].to_i]
    date = month.split('/')
    year = date[1].to_i
    year += 2000 if year < 100
    period_start = Date.new(year, date[0].to_i, 1)
    period_end = Date.new(year, date[0].to_i, -1)
    question_hash.each do |key, question|
      response = Response.new
      response.team_member_id = team_member.id
      response.question_id = question.id
      response.value = row[key.to_i]
      response.period_start = period_start
      response.period_end = period_end
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
    role = Role.find_by_name('member')
    return unless OrganizationRole.where(['organization_id = ? AND team_member_id = ? AND role_id = ?',
                            team.id, member.id, role.id]).empty?
    OrganizationRole.create(organization_id: team.id, team_member_id: member.id, role_id: role.id)
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
    return if email.nil?
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
