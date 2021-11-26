class CommentPolicy < ApplicationPolicy
  def destroy?
    user.has_any_role?(:super_admin, :content_manager)
  end

  def all_deleted?
    user.has_any_role?(:super_admin, :content_manager)
  end
end
