class RatingsController < ApplicationController
  def index
    @movie = Movie.find(params[:movie_id])
    @ratings = @movie.ratings
    render json: @ratings
  end  

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end
  
  private

  def rating_params
    params.require(:rating).permit(:score, :movie_id, :user_id)
  end
end
