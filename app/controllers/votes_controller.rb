class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_obj

  def create
    if !current_user.author_of?(@obj)
      vote = @obj.send("vote", current_user, vote_params)
      if vote.persisted?
        render json: { id: "#{@obj.class.name.underscore}_#{@obj.id}", rating: @obj.rating, action: "vote" }
      else
        render json: @obj.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: "Вы не можете это сделать", status: :forbidden 
    end
  end

  def destroy
    if @obj.author_of_vote?(current_user)
      vote = @obj.unvote(current_user)      
      if vote.persisted?
        render json: "Что-то пошло не так", status: :forbidden 
      else
        render json: { id: "#{@obj.class.name.underscore}_#{@obj.id}", rating: @obj.rating, action: "unvote" }
      end
    else
      render json: "Вы не можете это сделать", status: :forbidden 
    end
  end

  private

  def vote_params
    params.permit(:value)
  end

  def get_obj
    @obj = get_obj_by_url(request)
  end

  def get_obj_by_url(request)
    klass, id = request.path.split('/')[1,2]
    klass.singularize.classify.constantize.friendly.find(id)
  end

end
