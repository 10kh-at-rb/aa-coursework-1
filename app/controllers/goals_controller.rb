class GoalsController < ApplicationController
  before_action :redirect_if_not_logged_in

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
      redirect_to user_goals_url(@user)
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
      redirect_to user_goals_url(@goal.user)
    else
      render :edit
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :private, :completed)
  end

end
