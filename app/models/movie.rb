class Movie < ApplicationRecord
  has_and_belongs_to_many :actors, join_table: :actor_movies
  has_and_belongs_to_many :producers
  belongs_to :category
  validates :title, presence: true
  validates :release_year, presence: true
  validates :description, presence: true
  validates :rating, presence: true

  accepts_nested_attributes_for :actors
  accepts_nested_attributes_for :producers

  validate :actors_presence
  validate :producers_presence

  private

  def actors_presence
    if actors.empty?
      errors.add(:actors, "must be present")
    end
  end

  def producers_presence
    if producers.empty?
      errors.add(:producers, "must be present")
    end
  end
end
