FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
