module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote(current_user, vote_params)
    ActiveRecord::Base.transaction do
      value = (vote_params[:value] == 'up') ? 1 : -1
      @vote = self.votes.create!({user_id: current_user.id, value: value})
      self.update!(rating: sum )
      self.user.update!(rating: user_rating_sum )
    end
    @vote
  end

  def unvote(current_user)
    vote = get_vote_for_obj_by_user(current_user)
    ActiveRecord::Base.transaction do
      vote.destroy!
      self.update!(rating: sum)
      self.user.update!(rating: user_rating_sum )
    end
    vote
  end

  def author_of_vote?(user)
    get_vote_for_obj_by_user(user).user_id == user.id
  end

  def voted_for_by?(user)
    !!self.votes.where(user_id: user.id).take&.value
  end

  private 

  def sum
    self.votes.sum(:value)
  end

  def user_rating_sum
    self.user.recipes.sum(:rating) / 2.0
  end

  def get_vote_for_obj_by_user(user)
    self.votes.where(user_id: user.id).take  
  end
end
