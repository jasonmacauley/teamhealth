class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :slice_id

      t.timestamps
    end
  end
end
