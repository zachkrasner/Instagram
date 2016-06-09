class ProfilesController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
    unless @user
      flash[:alert] = "User not found"
      redirect_to posts_path
    else
      @posts = @user.posts.order("created_at DESC").page(params[:page]).per(6)
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
    else
      flash[:error] = "Couldn't update..."
    end
    redirect_to edit_profile_path
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end

  def get_user
    @user = User.find_by(username: params[:username])
  end

end
