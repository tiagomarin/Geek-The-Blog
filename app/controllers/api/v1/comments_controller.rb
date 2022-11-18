class Api::V1::CommentsController < Api::V1::ApplicationController
  def index
    comments = Comment.where(author_id: params[:author_id])
    render json: comments, status: :ok
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id, :author_id)
  end
end

# text
# some text
# post_id
# author_id
