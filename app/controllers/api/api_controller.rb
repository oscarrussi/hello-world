module Api
  class ApiController < ActionController::API
    include Pagy::Backend

    def authenticate_user
      decoded_token = JWT.decode(request.headers['Authorization'], Rails.application.credentials[:secret_token], false,
                                 { algorithm: 'HS256' })
      @current_user = User.find(decoded_token[0]['id'])
      head :unauthorized unless @current_user
    rescue StandardError => e
      render json: { "error": e }, status: :unauthorized
    end
  end
end
