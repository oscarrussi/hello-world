module ApiHelpers
  ROUTE_PATH = 'http://localhost:3000/api/'.freeze

  def login_route
    "#{ROUTE_PATH}login/"
  end

  def users_route
    "#{ROUTE_PATH}users/"
  end

  def articles_route
    "#{ROUTE_PATH}articles/"
  end

  def categories_route
    "#{ROUTE_PATH}categories/"
  end

  def comments_route
    "#{ROUTE_PATH}comments/"
  end

  def article_comments_route(id)
    "#{ROUTE_PATH}articles/#{id}/comments"
  end

  def user_roles_route(id)
    "#{ROUTE_PATH}users/#{id}/roles/update_many"
  end

  def hash_body
    JSON.parse(response.body)
  end

  def serialize_collection(models)
    models.map { |model| ActiveModelSerializers::SerializableResource.new(model) }.to_json
  end

  def serialize_model(model)
    ActiveModelSerializers::SerializableResource.new(model).to_json
  end
end
