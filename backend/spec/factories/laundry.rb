FactoryBot.define do
  factory :laundry do
    team
    user
    name { Faker::String.random(length: 3..12) }
    wash_at { Time.now.to_date + 7 }
  end
end