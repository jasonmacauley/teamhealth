class AddLabelToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :label, :string
  end
end
