class WelcomeController < ApplicationController
  respond_to :html

  def index
    @recipes = Recipe.only_published.paginate(page: params[:page], per_page: 20).eager_load(:user)
  end

  def search
    @recipes = Search.run(params[:search_type], params[:search])
  end
end
