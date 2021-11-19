require 'rails_helper'

RSpec.describe Api::UsersController, type: :routing do
  describe 'routing' do
    it { expect(post('api/users')).to route_to('api/users#create') }
    it { expect(put('api/users/1')).to route_to('api/users#update', id: '1') }
    it { expect(get('api/users/previous_versions/1')).to route_to('api/users#previous_versions', id: '1') }
  end
end
