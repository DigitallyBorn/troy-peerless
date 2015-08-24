FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role User.roles[:normal]

    trait :admin do
      role User.roles[:admin]
    end

    trait :board_member do
      role User.roles[:board_member]
    end

    factory :admin, traits: [:admin]
    factory :board_member, traits: [:board_member]
  end
end
