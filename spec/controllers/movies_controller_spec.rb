require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:valid_attributes) {
    {
      title: "Test Movie",
      release_year: 2022,
      description: "Test description",
      rating: 8.5,
      category_id: create(:category).id,
      actors_attributes: [{ name: "Actor 1" }],
      producers_attributes: [{ name: "Producer 1" }]
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      release_year: nil,
      description: nil,
      rating: nil,
      category_id: nil,
      actors_attributes: nil,
      producers_attributes: nil
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      movie = create(:movie)
      get :show, params: { id: movie.to_param }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new movie" do
        expect {
          post :create, params: { movie: valid_attributes }
        }.to change(Movie, :count).by(1)
      end

      it "renders a JSON response with the new movie" do
        post :create, params: { movie: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "does not create a new movie" do
        expect {
          post :create, params: { movie: invalid_attributes }
        }.to_not change(Movie, :count)
      end

      it "renders a JSON response with errors for the new movie" do
        post :create, params: { movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PATCH #update" do
    let(:movie) { create(:movie) }
    let(:new_attributes) { { title: "Updated Title" } }

    context "with valid parameters" do
      it "updates the requested movie" do
        patch :update, params: { id: movie.to_param, movie: new_attributes }
        movie.reload
        expect(movie.title).to eq("Updated Title")
      end

      it "renders a JSON response with the updated movie" do
        patch :update, params: { id: movie.to_param, movie: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: nil } }

      it "renders a JSON response with errors for the movie" do
        patch :update, params: { id: movie.to_param, movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:movie) { create(:movie) }

    it "destroys the requested movie" do
      expect {
        delete :destroy, params: { id: movie.to_param }
      }.to change(Movie, :count).by(-1)
    end

    it "returns a success response" do
      delete :destroy, params: { id: movie.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end
