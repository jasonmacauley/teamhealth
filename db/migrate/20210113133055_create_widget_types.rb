class CreateWidgetTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :widget_types do |t|
      t.string :name
      t.text :description
      t.string :partial

      t.timestamps
    end
  end
end
