class PostsController < ApplicationController

  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_author, only: [:edit, :update]

  def create
    @post = current_user.posts.new(post_params)
    if @post.save!
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_url(@post)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :body, :sub_id)
  end

  def redirect_if_not_author
    @post = Post.find(params[:id])
    redirect_to sub_url(@post.sub) unless current_user == @post.author
  end

  # def redirect_if_not_moderator
  #   @post = Post.find(params[:id])
  #   redirect_to posts_url unless current_user == @post.moderator
  # end

end
