class UsersController < ApplicationController
  # TODO before_action

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      # TODO redirect
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:password, :email)
  end
end
