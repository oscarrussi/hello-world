require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :routing do
  describe 'routing' do
    it { expect(get('api/categories')).to route_to('api/categories#index') }
    it { expect(put('api/categories/update_many')).to route_to('api/categories#update_many') }
  end
end
