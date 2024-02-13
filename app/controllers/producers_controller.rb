require_relative '../reports/base_reports'
require_relative '../reports/producers_report'

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
  
  def report_to_excel
    producers = Producer.all
    producers_report = ProducersReport.new(nil)
    producers_report.generate_report(producers)
    producers_report.export_to_excel('producers_report.xlsx')

    render json: { message: 'producers report has been generated and exported to Excel' }
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
