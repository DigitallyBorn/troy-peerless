# == Schema Information
#
# Table name: parking_spots
#
#  id         :integer          not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ParkingSpot < ActiveRecord::Base
  has_and_belongs_to_many :users
end
