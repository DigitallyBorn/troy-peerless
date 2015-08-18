# == Schema Information
#
# Table name: parking_spots
#
#  id         :integer          not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_parking_spots_on_number  (number) UNIQUE
#

require 'test_helper'

class ParkingSpotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
