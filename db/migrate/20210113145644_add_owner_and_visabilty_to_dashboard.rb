class AddOwnerAndVisabiltyToDashboard < ActiveRecord::Migration[6.0]
  def change
    add_column :dashboards, :user_id, :integer
    add_column :dashboards, :private, :boolean
  end
end
