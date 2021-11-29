class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :birthday
end
