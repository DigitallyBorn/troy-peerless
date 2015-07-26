# == Schema Information
#
# Table name: unit_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  unit_id    :integer
#  is_owner   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UnitUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
