require 'rails_helper'

RSpec.describe Api::Articles::CommentsController, type: :routing do
  describe 'routing' do
    it { expect(get('api/articles/1/comments')).to route_to('api/articles/comments#index', article_id: '1') }
  end
end
