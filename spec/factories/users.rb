FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    phone_number {"99999999"}
    sequence(:email) { |n| "name#{n}@gmail.com" }
    password { "123456" }
    password_confirmation {"123456"}
  end

  trait :admin do 
    sequence(:email) { |n| "admin#{n}@gmail.com"}
    admin {true}
  end
end