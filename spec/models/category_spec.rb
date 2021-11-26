require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { FactoryBot.build(:category) }
  describe 'associations' do
    it { should have_many(:articles) }
    it { should have_many(:article_categories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cod) }
    it { should validate_uniqueness_of(:cod).ignoring_case_sensitivity }
  end
end
