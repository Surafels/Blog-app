class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @posts =@user.posts if @user
   end

  def show
    @user = User.find_by_id(parms[:user_id])
    @post = Post.find_by_id(parms[:id])
   end
end
