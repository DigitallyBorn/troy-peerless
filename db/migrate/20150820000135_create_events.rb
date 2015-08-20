class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.string :title
      t.text :description
      t.string :location
      t.references :user

      t.timestamps null: false
    end
  end
end
