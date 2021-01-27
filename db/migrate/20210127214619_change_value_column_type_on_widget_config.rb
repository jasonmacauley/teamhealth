class ChangeValueColumnTypeOnWidgetConfig < ActiveRecord::Migration[6.0]
  def change
    change_column :widget_configs, :value, :text
  end
end
