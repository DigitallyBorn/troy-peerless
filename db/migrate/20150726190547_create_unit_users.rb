class CreateUnitUsers < ActiveRecord::Migration
  def change
    create_table :unit_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :unit, index: true, foreign_key: true
      t.boolean :is_owner

      t.timestamps null: false
    end
  end
end
