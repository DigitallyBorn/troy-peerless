class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :unit, index: true, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 0
      t.integer :scope, null: false, default: 0
      t.date :estimated_completion

      t.timestamps null: false
    end
  end
end
