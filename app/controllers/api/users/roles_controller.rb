module Api
  class Users::RolesController < ApiController
    before_action :authenticate_user
    before_action :is_super_admin
    before_action :set_user

    def update_many
      @user.roles = []
      params[:roles].each{|role| @user.add_role(role)}
      head :accepted
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end