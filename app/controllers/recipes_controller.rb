class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :state_handler]
  before_action :build_comment, only: :show

  respond_to :html

  def show
    respond_with(@comments = @recipe.comments.only_user.includes(:user))
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

  def state_handler
    @recipe.send("set_to_#{params[:state]}", params[:comment] ||= nil)
    redirect_to admin_index_path unless params[:state] == 'moderation'
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id]) if params[:id]
    @recipe = Recipe.find(params[:recipe_id]) if params[:recipe_id]
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :bootsy_image_gallery_id, ingredients_attributes:[:name,  :measure, :id, :_destroy])
  end

  def build_comment
    @comment = @recipe.comments.build
  end
end
