class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.integer :value
      t.integer :metric_type_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
