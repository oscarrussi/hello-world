require 'rails_helper'

RSpec.describe Api::CommentsController, type: :routing do
  describe 'routing' do
    it { expect(delete('api/comments/1')).to route_to('api/comments#destroy', id: '1') }
    it { expect(get('api/comments/all_deleted')).to route_to('api/comments#all_deleted') }
  end
end
