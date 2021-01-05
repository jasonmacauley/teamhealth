class RenameLableOnMetricType < ActiveRecord::Migration[6.0]
  def change
    rename_column :metric_types, :lable, :label
  end
end
