class GoalsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy, :show]

  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals

    render :index
  end

  def new
    @user = User.find(params[:user_id])
    @goal = @user.goals.new

    render :new
  end

  def create
    @user = User.find(params[:user_id])
    @goal = @user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to user_url(@goal.user)
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  def show
    @goal = Goal.find(params[:id])

    render :show
  end


  private

  def goal_params
    params.require(:goal).permit(:title, :content, :private, :completed)
  end

  def redirect_if_not_owner
    @goal = Goal.find(params[:id])
    redirect_to user_url(current_user) unless current_user == @goal.user
  end

end
