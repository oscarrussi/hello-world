module Api
  class ApiController < ActionController::API
    include Pagy::Backend
    include Pundit
    include JsonapiErrorsHandler
    rescue_from ::StandardError, with: lambda { |e| handle_error(e, :internal_server_error) }

    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    rescue_from ActiveRecord::RecordNotFound, with: lambda { |e| handle_error(e, :not_found) }
    rescue_from ActiveRecord::RecordInvalid, with: lambda { |e| handle_error(e, :unprocessable_entity) }
    rescue_from Pagy::OverflowError, with: lambda { |e| handle_error(e, :bad_request) }

    JsonapiErrorsHandler.configure do |config|
      config.handle_unexpected = true
    end

    private

    def handle_error(exception, status)
      render json: { error: exception.message }, status: status
    end

    def forbidden
      render json: { error: "you are not allowed to do this action" }, status: :forbidden
    end

    def current_user
      @current_user
    end

    def authenticate_user
      decoded_token = JWT.decode(request.headers["Authorization"], Rails.application.credentials[:secret_token], false,
                                 { algorithm: "HS256" })
      @current_user = User.find(decoded_token[0]["id"])
      head :unauthorized unless @current_user
    rescue StandardError => e
      render json: { "error": e }, status: :unauthorized
    end

    def is_admin
      authorize :admin, :admin?
    end

    def is_super_admin
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
