require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many(:movies).join_table(:actor_movies) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
