# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  user_id    :integer
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  s3_key     :string
#  s3_bucket  :string
#
# Indexes
#
#  index_documents_on_user_id  (user_id)
#

##
# The document model
class Document < ActiveRecord::Base
  enum category: [:general, :hoa_announcements, :owners_resources]

  belongs_to :user

  def self.in_category(category)
    where(category: category)
  end
end
