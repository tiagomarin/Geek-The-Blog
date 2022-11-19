class Api::V1::PostsController < Api::V1::ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.posts
  end

  def show
    post = Post.find(params[:id])
    render json: post.comments
  end
end
