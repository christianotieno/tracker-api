FactoryBot.define do
  factory :task do
    name { Faker::Name.first_name }
    date { Faker::Date.between(from: '2019-09-15', to: '2020-08-15') }
    notes { Faker::Lorem.word }
    done { true }
    schedule
  end
end
