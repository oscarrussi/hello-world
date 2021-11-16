class Category < ApplicationRecord
  validates :cod, uniqueness: true
end
