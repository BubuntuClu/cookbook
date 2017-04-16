class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :send_to_moderation, :send_to_publish, :send_to_draft]
  before_action :build_comment, only: :show

  respond_to :html

  def show
    respond_with @recipe
  end

  def new
    respond_with (@recipe = Recipe.new)
  end

  def create
    @recipe = Recipe.create(recipe_params.merge(user_id: current_user.id))
    respond_with @recipe
  end

  def destroy
    @recipe.destroy if can?(:destroy, @recipe)
    redirect_to user_profile_path(current_user)
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    respond_with @recipe
  end

  def send_to_moderation
    @recipe.set_to_moderation
  end

  def send_to_publish
    @recipe.set_to_publish
    redirect_to admin_index_path
  end

  def send_to_draft
    @recipe.set_to_draft(comment_params)
    redirect_to admin_index_path
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id]) if params[:id]
    @recipe = Recipe.find(params[:recipe_id]) if params[:recipe_id]
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :bootsy_image_gallery_id, ingredients_attributes:[:name,  :measure, :id, :_destroy])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def build_comment
    @comment = @recipe.comments.build
  end
end
