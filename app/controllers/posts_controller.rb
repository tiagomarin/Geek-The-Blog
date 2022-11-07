class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.last_3_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
