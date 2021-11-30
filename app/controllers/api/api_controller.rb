module Api
  class ApiController < ActionController::API
    include Pagy::Backend
    include Pundit
    include JsonapiErrorsHandler
    rescue_from ::StandardError, with: ->(e) { handle_error(e, :internal_server_error) }

    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    rescue_from ActiveRecord::RecordNotFound, with: ->(e) { handle_error(e, :not_found) }
    rescue_from ActiveRecord::RecordInvalid, with: ->(e) { handle_error(e, :unprocessable_entity) }
    rescue_from Pagy::OverflowError, with: ->(e) { handle_error(e, :bad_request) }
    rescue_from AASM::InvalidTransition, with: ->(e) { handle_error(e, :bad_request) }

    JsonapiErrorsHandler.configure do |config|
      config.handle_unexpected = true
    end

    private

    def handle_error(exception, status)
      render json: { errors: exception.message }, status: status
    end

    def forbidden
      render json: { error: 'you are not allowed to do this action' }, status: :forbidden
    end

    attr_reader :current_user

    def authenticate_user
      decoded_token = JWT.decode(request.headers['Authorization'], Rails.application.credentials[:secret_token], false,
                                 { algorithm: 'HS256' })
      @current_user = User.find(decoded_token[0]['id'])
      head :unauthorized unless @current_user
    rescue StandardError => e
      render json: { "error": e }, status: :unauthorized
    end

    def admin?
      authorize :admin, :admin?
    end

    def super_admin?
      authorize :admin, :super_admin?
    end

    def serialize_collection(models)
      models.map { |model| ActiveModelSerializers::SerializableResource.new(model) }
    end

    def serialize_model(model)
      ActiveModelSerializers::SerializableResource.new(model)
    end
  end
end
