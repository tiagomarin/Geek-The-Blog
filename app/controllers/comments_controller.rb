class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Error: comment could not be saved. Please try again'
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to user_post_path(current_user.id)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
