# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  number     :integer
#  floor      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_units_on_number  (number) UNIQUE
#

class Unit < ActiveRecord::Base
  has_and_belongs_to_many :owners,
    join_table: 'users_own_units',
    class_name: User

  has_many :users
end
