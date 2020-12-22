class CleanUpTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :teams
    drop_table :slices
    drop_table :team_memberships
  end
end
