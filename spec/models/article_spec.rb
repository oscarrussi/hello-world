require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.build(:article) }
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
    before do 
      30.times do |i| 
        article_ = FactoryBot.create(:article)
        article_.aasm.fire!(:reject) if i>=15
      end
    end
    subject { Article.pending_or_reviewing.size }
    it { should eq(15) }
  end

  describe 'methods' do
    subject { FactoryBot.build(:comment, user_id: user.id).user_email }
    it { should eq(user.email) }
  end
end