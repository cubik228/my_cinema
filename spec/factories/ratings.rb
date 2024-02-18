FactoryBot.define do
  factory :rating do
    user { nil }
    movie { nil }
    score { 1 }
  end
end
