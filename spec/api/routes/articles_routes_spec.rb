require 'rails_helper'

RSpec.describe Api::ArticlesController, type: :routing do
  describe 'routing' do
    it { expect(get('api/articles')).to route_to('api/articles#index') }
    it { expect(get('api/articles/1')).to route_to('api/articles#show', id: '1') }
    it { expect(post('api/articles')).to route_to('api/articles#create') }
    it { expect(put('api/articles/update_aasm')).to route_to('api/articles#update_aasm') }
  end
end
