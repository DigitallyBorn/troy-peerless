class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :number
      t.integer :floor

      t.timestamps null: false
    end
    add_index :units, :number, unique: true
  end
end
