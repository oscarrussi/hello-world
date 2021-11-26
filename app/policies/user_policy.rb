class UserPolicy < ApplicationPolicy
  def super_admin_or_myself?
    user.has_role?(:super_admin) || record.id == user.id
  end
end
