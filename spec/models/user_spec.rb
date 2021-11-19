require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }
  describe 'associations' do
    it { should have_many(:articles) }
    it { should have_many(:comments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity  }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end