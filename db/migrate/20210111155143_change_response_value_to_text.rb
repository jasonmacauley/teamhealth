class ChangeResponseValueToText < ActiveRecord::Migration[6.0]
  def change
    change_column :responses, :value, :text
  end
end
