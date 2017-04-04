class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :get_recipe, only: [:show, :edit, :update, :destroy]
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
    respond_with (@recipe.destroy) if can?(:destroy, @recipe)
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    respond_with @recipe
  end

  def send_on_moderation
    recipe = Recipe.find(params[:recipe_id])
    recipe.update_attributes(status: :moderation)
  end

  private

  def get_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :bootsy_image_gallery_id, ingredients_attributes:[:name,  :measure, :id, :_destroy])
  end

end
