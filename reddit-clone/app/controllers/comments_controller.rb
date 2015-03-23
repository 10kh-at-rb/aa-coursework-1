class CommentsController < ApplicationController

  def new
    fail
    @comment = Comment.new
    render :new
  end

  def create
    if params[:post_id]
      @post = Post.find(params[:post_id]) #find post by post id if coming from post
    else
      # @comment = Comment.find(params[:id])
      # @comment.
      # @comment = @post.comments.new(comment_params)
      #find comment by comment id, find post_id through grabbed comment
    end
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])

    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
