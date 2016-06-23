class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have successfully registered. Please sign in below"
      redirect_to sign_in_path
    else
      flash[:danger] = "Please enter valid details below"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
