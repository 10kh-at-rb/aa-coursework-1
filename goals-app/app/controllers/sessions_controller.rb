class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      log_in_user!(@user)
    else
      render :new
    end
  end

  def destroy
    log_out_user!(current_user)
  end
end
