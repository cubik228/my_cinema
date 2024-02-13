require_relative '../reports/base_reports'
require_relative '../reports/movies_report'


class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show update destroy]

  def index
    @movies = Movie.all
    render json: @movies
  end

  def actors
    movie = Movie.find(params[:id])
    actors = movie.actors

    render json: actors
  end

  def producers
    movie = Movie.find(params[:id])
    producers = movie.producers

    render json: producers
  end
  
  def report_to_excel
    movies = Movie.all
    movies_report = MoviesReport.new(nil)
    movies_report.generate_report(movies)
    movies_report.export_to_excel('movies_report.xlsx')

    render json: { message: 'Movies report has been generated and exported to Excel' }
  end

  def new 
    @movie = Movie.new
  end

  def show
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params)
    
    if @movie.save
      render json: @movie, status: :created
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @movie.destroy
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

 def movie_params
    params.require(:movie).permit(:title, :release_year, :description, :rating, 
      :category_id, actors_attributes: [:name], producers_attributes: [:name])
  end
end
