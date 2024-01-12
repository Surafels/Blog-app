class UsersController < ApplicationController
  def index
    @users = User.all
    # @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = @user.most_recent_posts(3)
  end
end
