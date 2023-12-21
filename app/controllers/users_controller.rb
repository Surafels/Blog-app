class UsersController < ApplicationController
  def index
    @user = User.all
   end

  def show
    @users = User.find(params[:id])
    @recent_posts = @user.most_recent_posts(3)
     end
end
