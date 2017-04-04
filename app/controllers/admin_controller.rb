class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.only_moderation.paginate(page: params[:page], per_page: 20)
  end
end
