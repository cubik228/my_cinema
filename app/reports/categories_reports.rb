require 'axlsx'


class CategoriesReport < BaseReport
  def generate_report(categories)
    report_data = categories.map do |categorie|
      {
        name: categorie.name,
      }
    end
    @data = report_data
  end
  

  def export_to_excel(file_name)
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(name: 'Categories Report') do |sheet|
      headers = ['Title']
      sheet.add_row(headers)
  
      @data.each do |categories_data|
        sheet.add_row(categories_data.values)
      end
    end
    p.serialize(file_name)
  end
end