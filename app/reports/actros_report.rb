require 'axlsx'


class ActorsReport < BaseReport
  def generate_report(actors)
    report_data = actors.map do |actor|
      {
        name: actor.name,
      }
    end
    @data = report_data
  end
  

  def export_to_excel(file_name)
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(name: 'Actors Report') do |sheet|
      headers = ['Title']
      sheet.add_row(headers)
  
      @data.each do |actors_data|
        sheet.add_row(actors_data.values)
      end
    end
    p.serialize(file_name)
  end
end