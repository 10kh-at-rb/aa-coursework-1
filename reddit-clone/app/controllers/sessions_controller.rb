class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create] 

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
      log_in_user!(@user)
    else
      @user = User.new
      flash.now[:errors] = "Username/Password Combination Invalid"
      render :new
    end

  end

  def destroy
    @user = current_user
    log_out_user!(@user)
  end

end
