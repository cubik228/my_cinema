require_relative '../reports/base_reports'
require_relative '../reports/actros_report'

class ActorsController < ApplicationController
  before_action :set_actor, only: %i[show update destroy]

  def index
    @actors = Actor.all
    render json: @actors
  end

  def movies
    @actor = Actor.find(params[:id])
    @movies = @actor.movies
    render json: @movies
  end
  
  def report_to_excel
    actors = Actor.all
    actors_report = ActorsReport.new(nil)
    actors_report.generate_report(actors)
    actors_report.export_to_excel('actors_report.xlsx')

    render json: { message: 'actors report has been generated and exported to Excel' }
  end

  def new
    @actor = Actor.new
  end

  def show
    render json: @actor
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      render json: @actor, status: :created
    else
      render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @actor.update(actor_params)
      render json: @actor
    else
      render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @actor.destroy
    head :no_content
  end

  private

  def set_actor
    @actor = Actor.find(params[:id])
  end

  def actor_params
    params.require(:actor).permit(:name)
  end
end
