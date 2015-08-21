# == Schema Information
#
# Table name: announcements
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  publish_date :datetime
#  title        :string
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_announcements_on_user_id  (user_id)
#

require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
