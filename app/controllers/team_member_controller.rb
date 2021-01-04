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
    @member.first_name = params[:team_member][:first_name]
    @member.last_name = params[:team_member][:last_name]
    title = Title.find(params[:team_member][:title_id])
    @member.title = title
    email = params[:team_member][:email]
    User.new(email: email, password: SecureRandom.hex).save if @member.user.nil?
    @member.user = User.find_by_email(email)
    @member.save
    redirect_to(show_team_member_path(@member))
  end

  def delete
    member = TeamMember.find(params[:id])
    member.user.delete
    member.delete
    redirect_to(team_member_index_path)
  end

  def create
  end

  def new
    @member = TeamMember.new
    @titles = Title.all
  end
end
