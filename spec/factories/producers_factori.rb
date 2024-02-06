FactoryBot.define do
  factory :producer do
    name { Faker::Name.name }
  end
end