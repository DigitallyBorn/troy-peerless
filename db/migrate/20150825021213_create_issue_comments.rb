class CreateIssueComments < ActiveRecord::Migration
  def change
    create_table :issue_comments do |t|
      t.references :issue, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.text :body, null: false
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end

    add_column :issues, :comment_count, :integer, default: 0
  end
end
