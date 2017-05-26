class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:create]

  def create
    @discussion = @comment.discussions.create(discussion_params.merge(user_id: current_user.id))
  end

  private

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def discussion_params
    params.require(:discussion).permit(:body)
  end
end
