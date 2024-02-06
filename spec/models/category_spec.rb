require 'rails_helper'

RSpec.describe Category, type: :model do
  # describe "validations" do
  #   let!(:existing_category) { create(:category, name: "Existing Name") }  # Create a valid record
    
  #   it { should validate_presence_of(:name) }
  # end
  
  describe "associations" do
    it { should have_one(:movie) }
  end
end
