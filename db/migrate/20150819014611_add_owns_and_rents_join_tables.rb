class AddOwnsAndRentsJoinTables < ActiveRecord::Migration
  def change
    create_join_table :users, :units, table_name: :users_own_units
    create_join_table :users, :units, table_name: :users_rent_units
  end
end
