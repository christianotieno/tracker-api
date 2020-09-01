FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
