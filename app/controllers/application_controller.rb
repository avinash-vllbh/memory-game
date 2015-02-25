class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :verify_logged_in

  def verify_logged_in
    unless params[:controller] == 'devise/sessions'
      if current_user
        return true
      else
        redirect_to new_user_session_path, :flash => {:alert => "You need to login!!!" }
      end
    end
  end

  def check_if_admin
    if current_user.try(:admin?)
      return true
    else
      # unless current_user && current_user.admin?
      redirect_to home_index_path, :flash => { :alert => "You are not allowed to do that!!!" }
    end
  end
end
