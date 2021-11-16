class AddColumnCod < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :cod, :string, unique: true
  end
end
