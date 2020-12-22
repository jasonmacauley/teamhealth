class CreateOrganizationRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_roles do |t|
      t.integer :organization_id
      t.integer :team_member_id
      t.integer :role_id

      t.timestamps
    end
  end
end
