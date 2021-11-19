require 'rails_helper'
require_relative 'context_api_login'

RSpec.describe 'Api::CommentsController', type: :request do
  include_context 'api login'
  let!(:article) { FactoryBot.create(:article) }
  let!(:user_comment) { FactoryBot.create(:comment, user_id: @user.id, article_id: article.id) }
  let!(:non_user_comment) { FactoryBot.create(:comment) }

  describe 'destroy' do
    context 'when wrong authorization is provided' do
      before { delete comments_route + user_comment.id.to_s, headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when nonexistent comment is requested' do
      before { delete "#{comments_route}#{Comment.last.id+1}", headers: { authorization: @authorization } }
      it { expect(hash_body['errors']).to match(/^Couldn't find Comment/) }
      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when existent comment is requested' do
      before { delete comments_route + user_comment.id.to_s, headers: { authorization: @authorization } }
      it { expect(response).to have_http_status(:ok) }
      it { expect(hash_body['id'].to_i).to eq user_comment.id }
    end

    context 'when logged user is not admin' do
      before do
        @user.roles=[]
        delete comments_route + non_user_comment.id.to_s, headers: { authorization: @authorization }
      end
      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'get_deleted' do
    context 'when wrong authorization is provided' do
      before { get comments_route + "get_deleted", headers: { authorization: '' } }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when no deleted comments' do
      before { get comments_route + "get_deleted", headers: { authorization: @authorization } }
      it { expect(hash_body.size).to eq 0 }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when there are comment deleted' do
      before do 
        30.times{FactoryBot.create(:comment)}
        5.times{Comment.last.destroy}
        get comments_route + "get_deleted", headers: { authorization: @authorization }
      end
      it { expect(hash_body.size).to eq 5 }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when logged user is not admin' do
      before do
        @user.roles=[]
        delete comments_route + "get_deleted", headers: { authorization: @authorization }
      end
      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end