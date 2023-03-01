class CommentsController < ApplicationController
  def create
    @new_comment = current_user&.comments&.build(comment_params)
    @post = @new_comment.post

    if @new_comment&.save
      @new_comment.broadcast_append_to @new_comment.post, locals: { current_user: current_user }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
