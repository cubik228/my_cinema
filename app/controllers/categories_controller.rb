require_relative '../reports/base_reports'
require_relative '../reports/categories_reports'

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]

  def index
    @categories = Category.all
    render json: @categories
  end

  def report_to_excel
    categories = Category.all
    categories_report = CategoriesReport.new(nil)
    categories_report.generate_report(categories)
    categories_report.export_to_excel('categories_report.xlsx')

    render json: { message: 'Movies report has been generated and exported to Excel' }
  end

  def new
    @category = Category.new
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
