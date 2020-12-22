class CreateTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_members do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
