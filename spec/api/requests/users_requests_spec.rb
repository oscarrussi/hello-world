require 'rails_helper'

RSpec.describe 'Api::UsersController', type: :request do
  let!(:password) { Faker::Number.unique.number(digits: 30).to_s }
  let!(:user) { FactoryBot.build(:user) }
  let!(:user_params) do
    { email: user.email, name: user.name, birthday: user.birthday, password: password,
      password_confirmation: password }
  end
  describe 'create' do
    context 'when valid params' do
      before { post users_route, params: user_params }
      it { expect(response).to have_http_status(:accepted) }
      it { expect(User.find_by_email(user_params[:email])).to_not be_nil }
      it { expect(hash_body['user']['name']).to eq user_params[:name] }
    end
    context 'when invalid email' do
      before do
        user_params_ = user_params
        user_params_[:email] = '1234'
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Email is invalid"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context 'when email is blank' do
      before do
        user_params_ = user_params
        user_params_.delete(:email)
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Email can't be blank"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context 'when name is blank' do
      before do
        user_params_ = user_params
        user_params_.delete(:name)
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Name can't be blank"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context 'when password is blank' do
      before do
        user_params_ = user_params
        user_params_.delete(:password)
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Password can't be blank, Password confirmation doesn't match Password"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context 'when password confirmation is blank' do
      before do
        user_params_ = user_params
        user_params_.delete(:password_confirmation)
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Password confirmation can't be blank"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context "when password confirmation doesn't match password" do
      before do
        user_params_ = user_params
        user_params_[:password_confirmation] =
          user_params[:password_confirmation] + Faker::Number.unique.number(digits: 1).to_s
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Password confirmation doesn't match Password"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end

    context 'when password is too short' do
      before do
        user_params_ = user_params
        user_params_[:password] = '12345'
        user_params_[:password_confirmation] = '12345'
        post users_route, params: user_params_
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expected_json = "Validation failed: Password is too short (minimum is 6 characters)"
        expect(hash_body['errors']).to eq(expected_json)
      end
    end
  end
end