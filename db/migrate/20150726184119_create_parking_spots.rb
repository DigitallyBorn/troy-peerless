class CreateParkingSpots < ActiveRecord::Migration
  def change
    create_table :parking_spots do |t|
      t.integer :number

      t.timestamps null: false
    end
    add_index :parking_spots, :number, unique: true

    create_join_table :parking_spots, :users
  end
end
