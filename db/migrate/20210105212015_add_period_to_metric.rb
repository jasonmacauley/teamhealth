class AddPeriodToMetric < ActiveRecord::Migration[6.0]
  def change
    add_column :metrics, :period_start, :date
    add_column :metrics, :period_end, :date
  end
end
