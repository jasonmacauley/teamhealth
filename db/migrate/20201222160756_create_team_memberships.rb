class CreateTeamMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :team_memberships do |t|
      t.integer :team_member_id
      t.integer :team_id
      t.integer :role_id

      t.timestamps
    end
  end
end
