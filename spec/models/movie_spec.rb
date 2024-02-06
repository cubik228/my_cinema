require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many(:actors).join_table(:actor_movies) }
    it { should have_and_belong_to_many(:producers) }
    it { should belong_to(:category) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:release_year) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:rating) }

    it "validates presence of actors" do
      movie = Movie.new
      movie.valid?
      expect(movie.errors[:actors]).to include("must be present")
    end

    it "validates presence of producers" do
      movie = Movie.new
      movie.valid?
      expect(movie.errors[:producers]).to include("must be present")
    end
  end

  describe "nested attributes" do
    it { should accept_nested_attributes_for(:actors) }
    it { should accept_nested_attributes_for(:producers) }
  end
end
