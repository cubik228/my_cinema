require 'axlsx'

class MoviesReport < BaseReport
  def generate_report(movies)
    report_data = movies.map do |movie|
      {
        title: movie.title,
        release_year: movie.release_year,
        description: movie.description,
        rating: movie.rating,
        category: movie.category.name
      }
    end
    @data = report_data
  end

  def export_to_excel(file_name)
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(name: 'Movies Report') do |sheet|
      headers = ['Title', 'Release Year', 'Description', 'Rating', 'Category']
      sheet.add_row(headers)
  
      @data.each do |movie_data|
        sheet.add_row(movie_data.values)
      end
    end
    p.serialize(file_name)
  end
end