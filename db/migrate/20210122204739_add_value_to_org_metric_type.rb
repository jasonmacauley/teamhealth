class AddValueToOrgMetricType < ActiveRecord::Migration[6.0]
  def change
    add_column :organization_metric_types, :value, :integer
  end
end
