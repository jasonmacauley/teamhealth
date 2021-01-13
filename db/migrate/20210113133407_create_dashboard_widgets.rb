class CreateDashboardWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboard_widgets do |t|
      t.integer :dashboard_id
      t.integer :widget_id
      t.string :name

      t.timestamps
    end
  end
end
