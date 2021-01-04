class TeamMemberController < ApplicationController
  def index
    @members = TeamMember.all
  end

  def show
    @member = TeamMember.find(params[:id])
  end

  def edit
    @member = TeamMember.find(params[:id])
    @titles = Title.all
  end

  def update
    @member = TeamMember.new
    unless params[:commit].match(/Create/)
      @member = TeamMember.find(params[:team_member][:id])
    end
    member_params = {
        'first_name' => params[:team_member][:first_name],
        'last_name' => params[:team_member][:last_name],
        'email' => params[:team_member][:email],
        'id' => @member.id,
        'title' => Ttitle.find(params[:team_member][:title_id])
    }
    update_member(member_params)
    redirect_to(show_team_member_path(@member))
  end

  def delete
    member = TeamMember.find(params[:id])
    member.user.delete
    member.delete
    redirect_to(team_member_index_path)
  end

  def import
    file = params[:file]
    CSV.foreach(file.path, headers: true) do |row|
      member_hash = {}
      name = row[0].split(' ')
      puts 'Name: ' + name[0]
      member_hash['first_name'] = name[0]
      member_hash['last_name'] = name[1]
      member_hash['email'] = row[1]
      title = get_or_create_title(row[2])
      member_hash['title'] = title
      update_member(member_hash)
    end
    redirect_to(team_member_index_path)
  end

  def new
    @member = TeamMember.new
    @titles = Title.all
  end

  private

  def get_or_create_title(title_name)
    Title.find_by_name(title_name).nil? ? title = Title.create(name: title_name) : title = Title.find_by_name(title_name)
    title
  end

  def update_member(member_params)
    @member = find_member_by_email(member_params['email'])
    @member = TeamMember.new if @member.nil?
    @member.first_name = member_params['first_name']
    @member.last_name = member_params['last_name']
    @member.title = member_params['title']
    email = member_params['email']
    User.new(email: email, password: SecureRandom.hex).save if @member.user.nil?
    @member.user = User.find_by_email(email)
    @member.save
  end

  def find_member_by_email(email)
    user = User.find_by_email(email)
    return nil if user.nil?

    TeamMember.find_by_user_id(user.id)
  end
end
