require 'rails_helper'
require_relative 'context_api_login'

RSpec.describe 'Api::ArticlesController', type: :request do
  include_context 'api login'
  before { 30.times{FactoryBot.create(:category)} }

  describe 'index' do
    context 'when wrong authorization is provided' do
      before { get categories_route, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when authorization is provided' do
      before {get categories_route, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body.size).to eq 30 }
      it { expect(hash_body.any?{|category| category["id"]==Category.last.id}).to be_truthy }
    end
  end

  describe 'create' do
    context 'when wrong authorization is provided' do
      before { get categories_route, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when authorization is provided' do
      before {get categories_route, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body.size).to eq 30 }
      it { expect(hash_body.any?{|category| category["id"]==Category.last.id}).to be_truthy }
    end
  end
end