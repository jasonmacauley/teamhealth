class AddAggregationMethodToMetricType < ActiveRecord::Migration[6.0]
  def change
    add_column :metric_types, :aggregation_method, :string
  end
end
