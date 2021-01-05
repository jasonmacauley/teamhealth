class CreateMetricTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :metric_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
