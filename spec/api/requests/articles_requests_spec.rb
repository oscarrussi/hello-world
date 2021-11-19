require 'rails_helper'
require_relative 'context_api_login'

RSpec.describe 'Api::ArticlesController', type: :request do
  include_context 'api login'
  before { 29.times{FactoryBot.create(:article)} }
  let!(:article){FactoryBot.create(:article)}

  describe 'index' do
    context 'when wrong authorization is provided' do
      before { get articles_route, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when authorization is provided' do
      before {get articles_route, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body.size).to eq 30 }
      # it { expect(hash_body['pagy']['count']).to eq 27 }
      # it { expect(hash_body['pagy']['page']).to eq 1 }
      # it { expect(hash_body['pagy']['pages']).to eq 2 }
      # it { expect(hash_body['books'].size).to eq 20 }
      it { expect(hash_body[29].to_json).to eq serialize_model(article) }
      # it { expect(hash_body['books'].none? { |book_| book_['name'] == last_book.name }).to be_truthy }
      # it { expect(hash_body.to_json).to eq serialize_model(Article.find(1)) }
      # it { expect(hash_body.any?{|category| category["id"]==Category.last.id}).to be_truthy }
    end
    context 'when user is not super_admin' do
      before do
        @user.roles=[]
        get articles_route, headers: { authorization: @authorization }
      end
      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'show' do
    context 'when wrong authorization is provided' do
      before { get articles_route+article.id.to_s, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when authorization is provided' do
      before {get articles_route+article.id.to_s, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body.to_json).to eq serialize_model(article) }
    end
  end

  describe 'create' do
    let!(:article_){FactoryBot.build(:article)}
    let!(:articles_params) {{ article: {title: article_.title, content: article_.content }}}
    context 'when wrong authorization is provided' do
      before { post articles_route, params: articles_params, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when authorization is provided' do
      before {post articles_route, params: articles_params, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:accepted) }
      it { expect(hash_body.to_json).to eq serialize_model(Article.find(hash_body["id"])) }
    end
  end
end