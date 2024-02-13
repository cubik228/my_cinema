require 'xlsx_writer'

class BaseReport
  def initialize(data)
    @data = data
  end

  def generate_report
    raise NotImplementedError, 'Subclasses must implement generate_report method'
  end

  def export_to_excel(file_name)
    raise NotImplementedError, 'Subclasses must implement export_to_excel method'
  end
end