class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @new_post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_path(current_user.id)
    else
      flash.now[:error] = 'Error: Post could not be saved. Please try again'
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
