require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.create(:comment, user_id: user.id) }
  describe 'associations' do
    it { should belong_to(:article) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'scope' do
    before { subject.destroy }
    it do
      user_email = Comment.only_deleted_with_user_email[0]['user_email']
      expect(user_email).to eq(user.email)
    end
  end
end
