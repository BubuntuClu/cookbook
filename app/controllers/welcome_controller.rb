class WelcomeController < ApplicationController
  respond_to :html

  def index
    @recipes = Recipe.only_published.paginate(page: params[:page], per_page: 20).eager_load(:user)
  end

  def search
    @result = Search.run(params[:search_type], params[:search])
    @type = params[:search_type]
  end
end
