class SessionsController < ApplicationController
  def create
    @user = User
      .find_by_credentials(params[:user][:email], params[:user][:password])
    if @user.nil?
      render :new
    else
      log_in_user!(@user)
    end
  end

  def new
    @user = User.new

    render :new
  end

  def destroy
    @user = current_user
    if @user
      @user.reset_session_token!
      session[:session_token] = nil
    end
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
