require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  subject { FactoryBot.build(:article_category) }
  describe 'associations' do
    it { should belong_to(:article) }
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_presence_of(:article_id) }
    it { should validate_presence_of(:category_id) }
    it {
      should validate_uniqueness_of(:article_id)
        .scoped_to(:category_id)
    }
  end
end
