class Actor < ApplicationRecord
  has_and_belongs_to_many :movies, join_table: :actor_movies
  validates :name, presence: true
end
