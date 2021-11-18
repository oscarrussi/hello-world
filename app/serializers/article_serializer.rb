class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :aasm_state, :available_transitions
end