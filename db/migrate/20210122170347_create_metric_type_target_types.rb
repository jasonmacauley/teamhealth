class CreateMetricTypeTargetTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :metric_type_target_types do |t|
      t.integer :metric_type_id
      t.integer :target_type_id

      t.timestamps
    end
  end
end
