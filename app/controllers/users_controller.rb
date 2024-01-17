class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    # @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = @user.most_recent_posts(3)
    if @user.nil?
      flash[:alert] = 'User not found.'
      redirect_to root_path
    end
  end
end
