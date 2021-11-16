class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
  validates :article_id, uniqueness: { scope: :category_id }
end
