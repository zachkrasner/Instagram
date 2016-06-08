class ProfilesController < ApplicationController

  def show
    @user = User.where(["username = :u", { u: params[:username] }]).first

    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(9)
  end

end
