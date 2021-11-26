require 'rails_helper'

RSpec.describe Api::Users::RolesController, type: :routing do
  describe 'routing' do
    it { expect(put('api/users/1/roles/update_many')).to route_to('api/users/roles#update_many', user_id: '1') }
  end
end
