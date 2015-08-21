class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :publish_date
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
