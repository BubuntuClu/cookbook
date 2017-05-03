class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:show]

  def index
    @recipes = current_user.recipes.paginate(page: params[:page], per_page: 20)
  end

  def show
    @recipes = @user.recipes.only_published.paginate(page: params[:page], per_page: 20)
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

end
