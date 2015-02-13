class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
    )

    if @user
      @user.reset_session_token
      log_in_user!(@user)
    else
      @user = User.new
      flash.now[:errors] = "Username/Password Combination Invalid"
      render :new
    end

  end

  def destroy
  end

end
