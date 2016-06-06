class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :destroy]

  def index
    @comments = Comment.all
  end

  def show

  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back
    else
      flash[:alert] = "Check the comment form, something went horribly wrong."
      render root_path
    end
  end

  def destroy
    @comment.destroy
    flash[:alert] = "Comment removed."
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

end
