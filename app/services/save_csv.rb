class SaveCsv
  def self.call(uploaded_io)
    csv_file = CsvFile.first
    if csv_file
      CsvFile.first.update(file: uploaded_io)
    else
      CsvFile.create!(file: uploaded_io)
    end
  end
end
