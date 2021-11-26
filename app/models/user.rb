class User < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_confirmation_of :password
  validates_presence_of :password_confirmation
  validates :name, presence: true
  validates :birthday, presence: true
  has_many :articles
  has_many :comments, through: :articles
end
