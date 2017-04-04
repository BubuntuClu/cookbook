class WelcomeController < ApplicationController
  respond_to :html

  def index
    @recipes = Recipe.only_published.paginate(page: params[:page], per_page: 20)
  end
end
