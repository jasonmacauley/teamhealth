class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :organization_type_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
