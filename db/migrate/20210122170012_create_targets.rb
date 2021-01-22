class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :targets do |t|
      t.string :name
      t.integer :target_type_id
      t.integer :organization_id
      t.integer :value
      t.date :period_start
      t.date :period_end

      t.timestamps
    end
  end
end
