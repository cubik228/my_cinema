require 'rails_helper'

RSpec.describe ActorsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:actor) { create(:actor) }

    it 'returns a success response' do
      get :show, params: { id: actor.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { attributes_for(:actor) }

      it 'creates a new actor' do
        expect {
          post :create, params: { actor: valid_attributes }
        }.to change(Actor, :count).by(1)
      end

      it 'renders a JSON response with the new actor' do
        post :create, params: { actor: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'renders a JSON response with errors for the new actor' do
        post :create, params: { actor: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    let(:actor) { create(:actor) }

    context 'with valid parameters' do
      let(:new_attributes) { { name: 'New Name' } }

      it 'updates the requested actor' do
        patch :update, params: { id: actor.to_param, actor: new_attributes }
        actor.reload
        expect(actor.name).to eq('New Name')
      end

      it 'renders a JSON response with the actor' do
        patch :update, params: { id: actor.to_param, actor: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'renders a JSON response with errors for the actor' do
        patch :update, params: { id: actor.to_param, actor: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:actor) { create(:actor) }

    it 'destroys the requested actor' do
      expect {
        delete :destroy, params: { id: actor.to_param }
      }.to change(Actor, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, params: { id: actor.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end
