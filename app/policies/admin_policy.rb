class AdminPolicy < ApplicationPolicy
  attr_reader :user, :resource

  def admin?
    @user.has_any_role?(:super_admin, :content_manager)
  end

  def super_admin?
    @user.has_role? :super_admin
  end
end
