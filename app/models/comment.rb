class Comment < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  validates_presence_of :message
  validates_presence_of :user_id
  belongs_to :user
  belongs_to :article

  def user_email
    user.email
  end
end
