class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:show]
  before_action :get_id, only: [:add_friend, :remove_friend]

  def index
    @recipes = current_user.recipes.paginate(page: params[:page], per_page: 20)
    @friends = []
    current_user.friends_list.friends.each do |friend_id|
       @friends << User.find(friend_id)
    end
  end

  def show
    @recipes = @user.recipes.only_published.paginate(page: params[:page], per_page: 20)
  end

  def add_friend
    current_user.friends_list.friends << @id
    current_user.friends_list.save
    render :friend_link
  end

  def remove_friend
    current_user.friends_list.friends.delete(@id)
    current_user.friends_list.save
    if params[:type]
      render :remove_friend
    else
      render :friend_link
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def get_id
    @id = params[:user_profile_id].to_i
  end

end
