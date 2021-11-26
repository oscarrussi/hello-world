class ArticlePolicy < ApplicationPolicy
  def create?
    user.has_role? :content_manager
  end
end
