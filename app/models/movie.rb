class Movie < ApplicationRecord
  has_and_belongs_to_many :actors, join_table: :actor_movies
  belongs_to :category, optional: true
end
