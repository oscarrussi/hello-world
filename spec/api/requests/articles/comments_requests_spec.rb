require 'rails_helper'
require_relative './../context_api_login'

RSpec.describe 'Api::Articles::CommentsController', type: :request do
  include_context 'api login'
  let!(:article) { FactoryBot.create(:article) }
  before{12.times{FactoryBot.create(:comment, article_id: article.id)}}

  describe 'index' do
    context 'when wrong authorization is provided' do
      before { get article_comments_route(article.id), headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when page is not provided' do
      before {get article_comments_route(article.id), headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body['pagy']['count']).to eq 12 }
      it { expect(hash_body['pagy']['page']).to eq 1 }
      it { expect(hash_body['pagy']['pages']).to eq 3 }
      it { expect(hash_body['comments'].size).to eq 5 }
      it { expect(hash_body['comments'][4].to_json).to eq serialize_model(Comment.where(article_id: article.id)[4]) }
      it { expect(hash_body['comments'].none? { |comment_| comment_['id'].to_i == Comment.where(article_id: article.id)[5].id }).to be_truthy }
    end
  end
end