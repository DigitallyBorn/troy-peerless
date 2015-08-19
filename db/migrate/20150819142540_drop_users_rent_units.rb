class DropUsersRentUnits < ActiveRecord::Migration
  def change
    drop_table :users_rent_units
  end
end
