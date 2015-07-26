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

class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
end
