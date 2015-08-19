class AddUnitToUser < ActiveRecord::Migration
  def change
    add_reference :users, :unit, index: true, foreign_key: true
  end
end
