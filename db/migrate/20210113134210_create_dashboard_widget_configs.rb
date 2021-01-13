class CreateDashboardWidgetConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboard_widget_configs do |t|
      t.integer :dashboard_widget_config_type_id
      t.integer :dashboard_widget_id
      t.string :value

      t.timestamps
    end
  end
end
