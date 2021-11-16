module Api
  class ApiController < ActionController::API
    include Pagy::Backend

    private

    def authenticate_user
      decoded_token = JWT.decode(request.headers['Authorization'], Rails.application.credentials[:secret_token], false,
                                 { algorithm: 'HS256' })
      @current_user = User.find(decoded_token[0]['id'])
      head :unauthorized unless @current_user
    rescue StandardError => e
      render json: { "error": e }, status: :unauthorized
    end

    def is_super_admin
      unless @current_user.has_role? :super_admin
        head :forbidden
      end
    end
  end
end
