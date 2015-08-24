FactoryGirl.define do
  sequence :unit_number

  factory :unit do
    number { generate(:unit_number) }
    floor 1
  end
end
