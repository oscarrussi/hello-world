class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
  validates_presence_of :article_id
  validates_presence_of :category_id
  validates :article_id, uniqueness: { scope: :category_id }
end
