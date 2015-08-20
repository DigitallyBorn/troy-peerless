class AddS3ColumnsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :s3_key, :string
    add_column :documents, :s3_bucket, :string
  end
end
