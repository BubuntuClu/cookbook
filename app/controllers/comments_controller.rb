class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_recipe, only: [:create]

  def create
    @comment = @recipe.comments.create(comment_params.merge(by_admin: false, user_id: current_user.id))
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
