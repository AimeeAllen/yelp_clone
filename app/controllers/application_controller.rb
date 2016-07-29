class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :redirect_if_not_logged_in

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def redirect_if_not_logged_in
    unless current_user
      if params[:controller] == 'businesses' and params[:action] == 'index'
        redirect_to root_path
      else
        flash[:danger] = "You must first login"
        redirect_to sign_in_path
      end
    end
  end
end
