class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    ingr = Ingredient.find(params[:id])
    ingr.destroy
    render json: ingr.id
  end

  def ingr_list
    if params[:query].present?
      @names = Ingredient
        .where('name ILIKE ?', "%#{params[:query]}%")
        .pluck(:name)
    end
    @names ||= []                  
    render json: @names
  end
end
