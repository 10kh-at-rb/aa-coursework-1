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
    @post = Post.find(params["id"])

    if @post
      render json: @post
    end
  end

  def index
    render json: Post.all
  end

  def destroy
    post = Post.find(params[:id])

    post.destroy
    render json: ""
  end



  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
