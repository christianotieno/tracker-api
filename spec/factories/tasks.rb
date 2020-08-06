FactoryBot.define do
  factory :task do
    name { Faker::Superhero.name }
    done { false }
    schedule_id { nil }
  end
end
