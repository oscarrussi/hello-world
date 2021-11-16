require 'csv'

class LoadCategoriesJob < ApplicationJob
  queue_as :default

  def perform
    CSV.parse(CsvFile.first.file.download, headers: true) do |row|
      category_from_csv(row)
    end
    puts 'categories successfully updated'
  rescue StandardError => e
    puts e.message
  end

  private

  def category_from_csv(row)
    category = Category.find_by_cod(row['cod'])
    save_category_from_csv(row, category.nil? ? Category.new : category)
  end

  def save_category_from_csv(row, category)
    category.cod = row['cod']
    category.name = row['name']
    category.save
  end
end
