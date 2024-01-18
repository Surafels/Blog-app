class LikesController < ApplicationController
  def new
    @like = Like.new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: @user)
    @user = User.find(params[:user_id])

    if @like.save
      redirect_to user_posts_path(@user, @post), notice: 'Like was successfully created.'
    else
      redirect_to user_posts_path(@user), alert: 'Error creating like.'
    end
  end
end
