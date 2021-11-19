require 'rails_helper'

RSpec.describe 'Api::LoginController', type: :request do
  let!(:password_) { Faker::Number.unique.number(digits: 30).to_s }
  let!(:user_) { FactoryBot.create(:user, password: password_, password_confirmation: password_) }

  describe 'create' do
    context 'when valid email and password' do
      before { post login_route, params: { email: user_.email, password: password_ } }
      it { expect(response).to have_http_status(:accepted) }
    end
    context 'when valid email and password' do
      before { post login_route, params: { email: '@', password: password_ } }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
    context 'when valid email and password' do
      before { post login_route, params: { email: user_.email, password: '' } }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
