class CreateIssueEvents < ActiveRecord::Migration
  def change
    create_table :issue_events do |t|
      t.references :issue, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :type, null: false
      t.string :message

      t.timestamps null: false
    end

    add_column :issues, :event_count, :integer, default: 0
  end
end
