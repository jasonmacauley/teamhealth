class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.integer :widget_type_id

      t.timestamps
    end
  end
end
