require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.create(:article) }
  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:article_categories) }
    it { should have_many(:categories) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:aasm_state) }
  end

  describe 'scopes' do
    context 'pending_or_reviewing' do
      before do
        30.times do |i|
          article_ = FactoryBot.create(:article)
          article_.aasm.fire!(:reject) if i >= 15
        end
      end
      subject { Article.pending_or_reviewing.size }
      it { should eq(15) }
    end
    context 'comments_with_user_email' do
      before do
        FactoryBot.create(:comment, user_id: user.id, article_id: subject.id)
      end
      it do
        user_email = subject.comments_with_user_email[0]['user_email']
        expect(user_email).to eq(user.email)
      end
    end
  end
end
