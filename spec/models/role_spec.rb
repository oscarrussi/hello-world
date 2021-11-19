require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'Role model creation' do
    subject { FactoryBot.build(:role) }

    describe 'associations' do
      it { should have_and_belong_to_many(:users) }
    end

    describe 'validations' do
      it { should validate_inclusion_of(:name).in_array(%w[super_admin content_manager]) }
    end
  end
end