class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :cod, uniqueness: true
  validates_presence_of :cod
  validates_presence_of :name
end
