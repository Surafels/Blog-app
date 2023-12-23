class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      redirect_to user_posts_path(current_user)
    else
      redirect_to user_posts_path(current_user), alert: 'Error creating like.'
    end
  end
end
