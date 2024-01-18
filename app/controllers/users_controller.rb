class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.find(params[:id])
    return unless @user.nil?

    flash[:notice] = 'Signed out successfully.'
    redirect_to root_path
    @recent_posts = @user.most_recent_posts(3)
    if @user.nil?
      flash[:alert] = 'User not found.'
      redirect_to root_path
    end
  end

  def user_sign_out
    sign_out current_user
    redirect_to new_user_session_path notice: 'Signed out successfully.'
  end
end
