class CreateTargetTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :target_types do |t|
      t.string :name
      t.string :implementation

      t.timestamps
    end
  end
end
