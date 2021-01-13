class AddPartialNameToDashboardWidgetConfigType < ActiveRecord::Migration[6.0]
  def change
    add_column :dashboard_widget_config_types, :partial_name, :string
  end
end
