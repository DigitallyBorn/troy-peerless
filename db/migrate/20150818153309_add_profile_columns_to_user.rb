class AddProfileColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :shared_email, :string
    add_column :users, :phone, :string
    add_column :users, :can_sms, :boolean
    add_column :users, :occupation, :string
    add_column :users, :bio, :text
  end
end
