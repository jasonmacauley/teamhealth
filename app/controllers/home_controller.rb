class HomeController < ApplicationController
  def index
    @team_member = TeamMember.find_by_user_id(current_user.id)
    @dashboards = Dashboard.where(user_id: current_user.id)
  end
end
