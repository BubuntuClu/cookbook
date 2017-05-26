class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    ingr = Ingredient.find(params[:id])
    ingr.destroy
    render json: ingr.id
  end
end
