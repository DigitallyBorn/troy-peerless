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
end
