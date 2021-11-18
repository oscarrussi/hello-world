class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :user_email, :article_id
end
