require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) { attributes_for(:category) }
  let(:invalid_attributes) { { name: nil } }
  let(:new_name) { "New Category Name" }
  let(:category) { create(:category) }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new category" do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it "renders a JSON response with the new category" do
        post :create, params: { category: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "does not create a new category" do
        expect {
          post :create, params: { category: invalid_attributes }
        }.to_not change(Category, :count)
      end

      it "renders a JSON response with errors for the new category" do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: new_name } }

      it "updates the requested category" do
        patch :update, params: { id: category.to_param, category: new_attributes }
        category.reload
        expect(category.name).to eq(new_name)
      end

      it "renders a JSON response with the updated category" do
        patch :update, params: { id: category.to_param, category: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the category" do
        patch :update, params: { id: category.to_param, category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
