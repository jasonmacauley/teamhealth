class CreateWidgetConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :widget_configs do |t|
      t.integer :dashboard_widget_config_type_id
      t.integer :widget_id
      t.string :value

      t.timestamps
    end
  end
end
