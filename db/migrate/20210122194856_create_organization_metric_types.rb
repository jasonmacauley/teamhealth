class CreateOrganizationMetricTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_metric_types do |t|
      t.integer :metric_type_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
