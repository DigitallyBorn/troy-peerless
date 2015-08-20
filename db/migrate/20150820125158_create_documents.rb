class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :url
      t.references :user, index: true, foreign_key: true
      t.string :category

      t.timestamps null: false
    end
  end
end
