class SessionsController < ApplicationController
  def create
    @user = User
      .find_by_credentials(params[:user][:email], params[:user][:password])
    if @user.nil?
      render :new
    else
      if @user.activated
        log_in_user!(@user)
      else
        flash[:message] = "Your account has not yet been activated."
        redirect_to new_session_url
      end
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

    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
