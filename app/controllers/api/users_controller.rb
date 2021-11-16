module Api
  class UsersController < ApiController

    def create
      user = User.new(user_params)
      if user.valid?
        user.save
        authorization = JWT.encode({ id: user.id }, Rails.application.credentials[:secret_token], 'HS256')
        render json: { "Authorization": authorization, "user": user }, status: :accepted
      else
        render json: { "errors": user.errors.messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :name, :birthday, :password, :password_confirmation)
    end
  end
end