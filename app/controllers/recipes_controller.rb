class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_recipe, only: [:show, :edit, :update, :destroy]
  respond_to :html

  # authorize_resource

  def index
    # respond_with (@recipes = Recipe.all.page(params[:page]))
    @recipes = Recipe.paginate(page: params[:page], per_page: 20)
  end

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

  private

  def get_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, ingredients_attributes:[:name,  :measure, :id, :_destroy])
  end

end
