class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
