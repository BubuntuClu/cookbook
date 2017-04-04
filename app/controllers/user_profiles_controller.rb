class UserProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.paginate(page: params[:page], per_page: 20)
  end

end
