class CreateSlices < ActiveRecord::Migration[6.0]
  def change
    create_table :slices do |t|
      t.string :name

      t.timestamps
    end
    add_index :slices, :name
  end
end
