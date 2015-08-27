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

FactoryGirl.define do
  sequence :unit_number

  factory :unit do
    number { generate(:unit_number) }
    floor 1
  end
end
