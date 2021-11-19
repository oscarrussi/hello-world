RSpec.shared_context 'api login' do
  before do
    password = Faker::Number.unique.number(digits: 30).to_s
    @user = FactoryBot.create(:user, password: password, password_confirmation: password)
    @user.add_role :super_admin
    @user.add_role :content_manager
    post login_route, params: { email: @user.email, password: password }
    @authorization = hash_body['authorization']
  end
end
