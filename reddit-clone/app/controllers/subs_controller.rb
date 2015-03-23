class SubsController < ApplicationController

  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all

    render :index
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end

  end

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.update(sub_params)
    redirect_to sub_url(@sub)
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_if_not_moderator
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user == @sub.moderator
  end

end
