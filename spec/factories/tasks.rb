FactoryBot.define do
  factory :task do
    name { Faker::StarWars.character }
    done { false }
    schedule_id nil
  end
end
