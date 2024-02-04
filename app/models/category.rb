class Category < ApplicationRecord
  has_one :movie
  validates :name, presence: true, uniqueness: true
end
