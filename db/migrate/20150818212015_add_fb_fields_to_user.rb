class AddFbFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :facebook_url, :string
  end
end
