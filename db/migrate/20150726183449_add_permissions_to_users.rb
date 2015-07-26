class AddPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_board, :boolean, default: false
  end
end
