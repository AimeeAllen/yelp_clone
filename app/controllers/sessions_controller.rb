class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]

  def new
    redirect_to home_path if current_user
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}"
      redirect_to home_path
    else
      session[:user_id] = nil
      flash[:danger] = "Invalid username and/or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
