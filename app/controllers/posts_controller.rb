class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owns_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been published!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your post could not be created. Please check the form"
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully updated."
      redirect_to post_path(@post)
    else
      flash[:error] = "Couldn't updated post at this time."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owns_post
    unless @post.user == current_user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to posts_path
    end
  end
end
