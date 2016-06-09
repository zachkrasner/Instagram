class ProfilesController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
    unless @user
      flash[:alert] = "User not found"
      redirect_to posts_path
    else
      @posts = @user.posts.order("created_at DESC").page(params[:page]).per(6)
    end
  end

end
