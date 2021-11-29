module Api
  class UsersController < ApiController
    before_action :authenticate_user, only: %i[previous_versions update]
    before_action :set_user, only: %i[previous_versions update]
    before_action :super_admin_or_myself, only: %i[previous_versions update]

    def create
      user = User.new(user_params)
      user.save!
      authorization = JWT.encode({ id: user.id }, Rails.application.credentials[:secret_token], 'HS256')
      render json: { "Authorization": authorization, "user": serialize_model(user) }, status: :accepted
    end

    def update
      @user.update!(user_params)
      render json: @user, status: :accepted
    end

    def previous_versions
      @users = @user.versions.map(&:reify).compact
      render json: @users
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:email, :name, :birthday, :password, :password_confirmation)
    end

    def super_admin_or_myself
      authorize @user, :super_admin_or_myself?
    end
  end
end
