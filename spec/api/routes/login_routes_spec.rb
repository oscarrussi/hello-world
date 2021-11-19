require 'rails_helper'

RSpec.describe Api::LoginController, type: :routing do
  describe 'routing' do
    it { expect(post('api/login')).to route_to('api/login#create') }
  end
end
