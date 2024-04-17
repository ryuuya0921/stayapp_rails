class DropProfilesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :profiles
  end
end
