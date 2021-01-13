class CreateWidgetConfigTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :widget_config_types do |t|
      t.integer :dashboard_widget_config_type_id
      t.integer :widget_type_id

      t.timestamps
    end
  end
end
