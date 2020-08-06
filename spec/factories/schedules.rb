FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end
