class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3) if @user
  end

  def show
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.find(params[:id])
   
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = .posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:success] = 'Post saved successfully'

      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
