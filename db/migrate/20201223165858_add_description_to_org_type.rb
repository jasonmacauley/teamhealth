class AddDescriptionToOrgType < ActiveRecord::Migration[6.0]
  def change
    add_column :organization_types, :description, :text
  end
end
