class SessionsController < ApplicationController
  # TODO before_action

  def create
    puts "INSIDE: create"
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      puts "INSIDE: nil"
      flash.now[:errors] = ["Incorrect email and/or password"]
      render :new
    else
      puts "INSIDE: else"
      login_user!(user)
      redirect_to session_url
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  def new
    render :new
  end
end
