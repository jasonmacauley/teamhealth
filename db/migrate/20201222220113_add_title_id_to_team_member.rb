class AddTitleIdToTeamMember < ActiveRecord::Migration[6.0]
  def change
    add_column :team_members, :title_id, :integer
  end
end
