# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  user_id    :integer
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_documents_on_user_id  (user_id)
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
