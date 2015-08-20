class ChangeCategoryToIntegerInDocuments < ActiveRecord::Migration
  def up
    change_column :documents, :category, 'integer USING CAST(category AS integer)'
  end

  def down
    change_column :documents, :category, :string
  end
end
