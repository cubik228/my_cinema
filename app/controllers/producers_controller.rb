class ProducersController < ApplicationController
  before_action :set_producer, only: %i[show update destroy]

  def index
    @producers = Producer.all
    render json: @producers
  end

  def movies
    @producer = Producer.find(params[:id])
    @movies = @producer.movies
    render json: @movies
  end
  
  
  def new
    @producer = Producer.new
  end

  def show
    render json: @producer
  end

  def create
    @producer = Producer.new(producer_params)

    if @producer.save
      render json: @producer, status: :created
    else
      render json: { errors: @producer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @producer.update(producer_params)
      render json: @producer
    else
      render json: { errors: @producer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @producer.destroy
    head :no_content
  end

  private

  def set_producer
    @producer = Producer.find(params[:id])
  end

  def producer_params
    params.require(:producer).permit(:name)
  end
end
