class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def show
    @post = Post.find(:id)

    if @post
      render json: @post
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
