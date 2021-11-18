class Comment < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :user
  belongs_to :article

  def user_email
    user.email
  end
end
