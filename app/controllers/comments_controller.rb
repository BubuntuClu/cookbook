class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    Recipe.find(params[:recipe_id]).comments.create(permitted_params)
    ##TODO (вопрос 1) как можно сделать по-хорошему? 
    redirect_to recipe_send_to_draft_path
  end

  private

  def permitted_params
    params.require(:comment).permit(:body)
  end
end
