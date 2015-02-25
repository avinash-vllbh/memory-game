module Admin
  class UsersController < ApplicationController
    before_filter :check_if_admin

    def index
      @users = User.all
    end

    def destroy
      User.destroy(params[:id])
      redirect_to admin_users_path
    end
  end
end