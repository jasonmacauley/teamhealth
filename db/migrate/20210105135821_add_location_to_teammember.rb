class AddLocationToTeammember < ActiveRecord::Migration[6.0]
  def change
    add_column :team_members, :location_id, :integer
  end
end
