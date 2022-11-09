class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    like.author = current_user
    if like.save
      redirect_to user_post_path(current_user.id)
    else
      flash.now[:error] = 'Error: like could not be saved. Please try again'
      render :new
    end
  end

  def like_params
    params.require(:like).permit(:author, :post)
  end
end
