FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_year { Faker::Number.between(from: 1900, to: 2024) }
    description { Faker::Lorem.paragraph }
    rating { Faker::Number.between(from: 1.0, to: 10.0) }
    association :category

    after(:build) do |movie|
      movie.actors << FactoryBot.build(:actor)
      movie.producers << FactoryBot.build(:producer)
    end

    factory :movie_with_actors_and_producers do
      transient do
        actors_count { 3 }
        producers_count { 2 }
      end

      after(:build) do |movie, evaluator|
        movie.actors = create_list(:actor, evaluator.actors_count)
        movie.producers = create_list(:producer, evaluator.producers_count)
      end
    end
  end
end
