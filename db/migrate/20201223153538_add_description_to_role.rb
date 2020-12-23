class AddDescriptionToRole < ActiveRecord::Migration[6.0]
  def change
    add_column :roles, :description, :text
  end
end
