class AddLableToMetricType < ActiveRecord::Migration[6.0]
  def change
    add_column :metric_types, :lable, :string
  end
end
