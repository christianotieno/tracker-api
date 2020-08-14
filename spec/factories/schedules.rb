FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.word }
    user
  end
end
