class DropUnitUsers < ActiveRecord::Migration
  def change
    drop_table :unit_users
  end
end
