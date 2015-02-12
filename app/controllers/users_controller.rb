class UsersController < ApplicationController
  before_action :redirect_if_not_admin, only: [:index, :make_admin]
  def index
    @users = User.all

    render :index
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:message] = "Please check your email for your activation link."
      redirect_to bands_url
    else
      render :new
    end
  end

  def new
    @user = User.new

    render :new
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    if @user
      @user.activated = true
      @user.save
      log_in_user!(@user)
    else
      flash[:message] = "Invalid Activation Token"
      redirect_to bands_url
    end
  end

  def make_admin
    User.find(params[:id]).make_admin!
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
