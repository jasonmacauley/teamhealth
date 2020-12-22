class CreateOrganizationsTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations_team_members do |t|
      t.integer :organization_id
      t.integer :team_member_id

      t.timestamps
    end
  end
end
