require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  before do 
    @user = create(:user) 
    @recipe = create(:recipe, user: @user)
    @user2 = create(:user)
    sign_in @user2
  end

  describe 'POST #create' do
    context 'vote for recipe' do
      it 'increase votes for recipe' do
        expect { post :create, params:{ recipe_id: @recipe, value: 'up', format: :json } }.to change(@recipe.votes.where(user_id: @user2.id), :count).by(1)
      end

      it 'renders needed fields in JSON' do
        post :create, params:{ recipe_id: @recipe, value: 'down', format: :json }
        expect(response).to have_http_status :success

        result = JSON.parse(response.body)
        @recipe.reload
        expect(result["action"]).to eq('vote')
        expect(result["id"]).to eq("recipe_#{@recipe.id}")
        expect(result["rating"]).to eq(@recipe.rating)
      end
    end
  end

  describe 'DELETE #destroy' do
    before{ post :create, params:{ recipe_id: @recipe, value: 'up', format: :json  } }
    context 'unvote for recipe' do
      it 'change votes for recipe' do
        expect { delete :destroy, params:{ recipe_id: @recipe , id: @recipe }, format: :json }.to change(@recipe.votes.where(user_id: @user2.id), :count).by(-1)
      end

      it 'renders needed fields in JSON' do
        delete :destroy, params:{ recipe_id: @recipe , id: @recipe  }, format: :json 
        expect(response).to have_http_status :success

        result = JSON.parse(response.body)
        @recipe.reload
        expect(result["action"]).to eq('unvote')
        expect(result["id"]).to eq("recipe_#{@recipe.id}")
        expect(result["rating"]).to eq(@recipe.rating)
      end
    end
  end
end


