class RemoveRoleColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :is_admin, :boolean
    remove_column :users, :is_board, :boolean
  end
end
