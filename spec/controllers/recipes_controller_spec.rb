require 'rails_helper'

RSpec.describe RecipesController, type: :controller do 
  before  do 
    @user = create(:user) 
    @admin = create(:admin)
  end
  let(:draft_recipe) { create(:draft_recipe, user: @user) }
  let(:moderation_recipe) { create(:moderation_recipe, user: @user) }
  
  
  context 'simple user' do
    before { sign_in(@user) }

    describe 'POST#moderation' do
      it 'change status to moderation' do
        post :set_state, recipe_id: draft_recipe.id, format: :js, state: :moderation
        draft_recipe.reload
        expect(draft_recipe.status).to eq "moderation"
      end
    end

    describe 'POST#publish' do
      it 'try change status to publish' do
        post :set_state, recipe_id: moderation_recipe.id, state: :publish
        moderation_recipe.reload
        expect(moderation_recipe.status).to eq "moderation"
      end

      it 'redirect to admin index' do
        post :set_state, recipe_id: draft_recipe.id, state: :publish
        expect(response).to redirect_to admin_index_path
      end
    end

    describe 'POST#draft' do
      it 'try change status to draft' do
        post :set_state, recipe_id: moderation_recipe.id , comment: {body: 'test comment'}, state: :draft
        moderation_recipe.reload
        expect(moderation_recipe.status).to eq "moderation"
      end

      it 'redirect to admin index' do
        post :set_state, recipe_id: moderation_recipe.id, comment: {body: 'test comment'}, state: :draft
        expect(response).to redirect_to admin_index_path
      end
    end
  end

  context 'admin user' do
    before { sign_in(@admin) }

    describe 'POST#moderation' do
      it 'try change status to moderation' do
        post :set_state, recipe_id: draft_recipe.id, format: :js, state: :moderation
        draft_recipe.reload
        expect(draft_recipe.status).to eq "draft"
      end
    end

    describe 'POST#publish' do
      it 'change status to publish' do
        post :set_state, recipe_id: moderation_recipe.id, state: :publish
        moderation_recipe.reload
        expect(moderation_recipe.status).to eq "published"
      end

      it 'redirect to admin index' do
        post :set_state, recipe_id: draft_recipe.id, state: :publish
        expect(response).to redirect_to admin_index_path
      end
    end

    describe 'POST#draft' do
      it 'change status to draft' do
        post :set_state, recipe_id: moderation_recipe.id , comment: {body: 'test comment'}, state: :draft
        moderation_recipe.reload
        expect(moderation_recipe.status).to eq "draft"
      end

      it 'redirect to admin index' do
        post :set_state, recipe_id: moderation_recipe.id, comment: {body: 'test comment'}, state: :draft
        expect(response).to redirect_to admin_index_path
      end
    end
  end
end
