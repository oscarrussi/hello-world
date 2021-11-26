module Api
  class LoginController < ApiController
    def create
      user = User.find_by_email(params[:email])
      if user&.valid_password?(params[:password])
        authorization = JWT.encode({ id: user.id }, Rails.application.credentials[:secret_token], 'HS256')
        render json: { "authorization": authorization }, status: :accepted
      else
        head :unprocessable_entity
      end
    end
  end
end
