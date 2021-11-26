class Article < ApplicationRecord
  include AASM
  acts_as_paranoid
  has_paper_trail
  belongs_to :user
  has_many :comments
  has_many :article_categories
  has_many :categories, :through => :article_categories
  validates :aasm_state, presence: true
  validates :title, presence: true
  validates :content, presence: true
  scope :pending_or_reviewing, -> { where("aasm_state = 'pending' or aasm_state='reviewing'") }

  def comments_with_user_email
    Comment.joins(:user).select('comments.id, comments.message, comments.article_id, users.email as user_email').where(article_id: id)
  end

  def available_transitions
    self.aasm.permitted_transitions
        .map{|s| {event: s[:event], state: s[:state]}}
  end

  aasm do # default column: aasm_state
    state :pending, initial: true
    state :reviewing
    state :accepted
    state :rejected

    event :review do
      transitions from: :pending, to: :reviewing
    end

    event :accept do
      transitions from: :reviewing, to: :accepted
    end

    event :reject do
      transitions from: ["pending", "reviewing"], to: :rejected
    end
  end
end
