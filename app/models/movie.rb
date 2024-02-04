class Movie < ApplicationRecord
  has_and_belongs_to_many :actors, join_table: :actor_movies
  belongs_to :category
  validates :title, presence: true
  validates :release_year, presence: true
  validates :description, presence: true
  validates :rating, presence: true
end
