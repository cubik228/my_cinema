require 'rails_helper'

RSpec.describe ProducersController, type: :controller do
  let(:valid_attributes) { attributes_for(:producer) }
  let(:invalid_attributes) { { name: nil } }
  let(:producer) { create(:producer) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: producer.to_param }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new producer" do
        expect {
          post :create, params: { producer: valid_attributes }
        }.to change(Producer, :count).by(1)
      end

      it "renders a JSON response with the new producer" do
        post :create, params: { producer: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "does not create a new producer" do
        expect {
          post :create, params: { producer: invalid_attributes }
        }.to_not change(Producer, :count)
      end

      it "renders a JSON response with errors for the new producer" do
        post :create, params: { producer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PATCH #update" do
    let(:new_name) { "New Producer Name" }
    let(:new_attributes) { { name: new_name } }

    context "with valid parameters" do
      it "updates the requested producer" do
        patch :update, params: { id: producer.to_param, producer: new_attributes }
        producer.reload
        expect(producer.name).to eq(new_name)
      end

      it "renders a JSON response with the updated producer" do
        patch :update, params: { id: producer.to_param, producer: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the producer" do
        patch :update, params: { id: producer.to_param, producer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested producer" do
      producer
      expect {
        delete :destroy, params: { id: producer.to_param }
      }.to change(Producer, :count).by(-1)
    end

    it "returns a success response" do
      delete :destroy, params: { id: producer.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end
