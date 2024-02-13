require 'axlsx'


class ProducersReport < BaseReport
  def generate_report(producers)
    report_data = producers.map do |producer|
      {
        name: producer.name,
      }
    end
    @data = report_data
  end
  

  def export_to_excel(file_name)
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(name: 'Producers Report') do |sheet|
      headers = ['Title']
      sheet.add_row(headers)
  
      @data.each do |producers_data|
        sheet.add_row(producers_data.values)
      end
    end
    p.serialize(file_name)
  end
end