require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.build(:comment) }
  describe 'associations' do
    it { should belong_to(:article) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'methods' do
    subject { FactoryBot.build(:comment, user_id: user.id).user_email }
    it { should eq(user.email) }
  end
end