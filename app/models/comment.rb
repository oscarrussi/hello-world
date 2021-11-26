class Comment < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  validates_presence_of :message
  validates_presence_of :user_id
  belongs_to :user
  belongs_to :article

  def self.only_deleted_with_user_email
    self.only_deleted.joins(:user).select('comments.id, comments.message, comments.article_id, users.email as user_email')
  end
end
