class ActorsController < ApplicationController
  before_action :set_actor, only: %i[show update destroy]

  def index
    @actors = Actor.all
    render json: @actors
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
