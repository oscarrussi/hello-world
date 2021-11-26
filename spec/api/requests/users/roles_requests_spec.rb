require 'rails_helper'
require_relative './../context_api_login'

RSpec.describe 'Api::Users::RolesController', type: :request do
  include_context 'api login'
  let!(:user_) { FactoryBot.create(:user) }

  describe 'index' do
    context 'when wrong authorization is provided' do
      before { put user_roles_route(user_.id), headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when non existent user' do
      before { put user_roles_route(User.all.pluck(:id).max+1), headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when invalid role is provided' do
      before { put user_roles_route(user_.id), params: {roles: ["soccer_player", "content_manager"]}, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(user_.roles.pluck(:name).sort.join(",")).to_not eq("content_manager,soccer_player") }
    end

    context 'when valid roles are provided' do
      before { put user_roles_route(user_.id), params: {roles: ["super_admin", "content_manager"]}, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:accepted) }
      it { expect(user_.roles.pluck(:name).sort.join(",")).to eq("content_manager,super_admin") }
    end
  end
end