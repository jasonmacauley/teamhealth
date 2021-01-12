class AddPeriodToResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :responses, :period_start, :date
    add_column :responses, :period_end, :date
  end
end
