class Article < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  has_many :comments
  has_many :article_categories
  has_many :categories, :through => :article_categories
end
