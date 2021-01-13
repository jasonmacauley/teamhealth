class AddLabelToDashboardWidgetConfigType < ActiveRecord::Migration[6.0]
  def change
    add_column :dashboard_widget_config_types, :label, :string
  end
end
