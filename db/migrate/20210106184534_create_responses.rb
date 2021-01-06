class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :team_member_id
      t.integer :question_id
      t.integer :value

      t.timestamps
    end
  end
end
