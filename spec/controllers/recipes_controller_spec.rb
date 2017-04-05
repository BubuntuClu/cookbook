require 'rails_helper'

RSpec.describe RecipesController, type: :controller do 
  before  { @user = create(:user) }
  let(:draft_recipe) { create(:draft_recipe, user: @user) }
  let(:moderation_recipe) { create(:moderation_recipe, user: @user) }
  sign_in_user
  
  describe 'POST#send_to_moderation' do
    it 'change status to moderation' do
      post :send_to_moderation, recipe_id: draft_recipe.id, format: :js
      draft_recipe.reload
      expect(draft_recipe.status).to eq "moderation"
    end
  end

  describe 'POST#send_to_publish' do
    it 'change status to publish' do
      post :send_to_publish, recipe_id: draft_recipe.id
      draft_recipe.reload
      expect(draft_recipe.status).to eq "published"
    end

    it 'redirect to admin index' do
      post :send_to_publish, recipe_id: draft_recipe.id
      expect(response).to redirect_to admin_index_path
    end
  end

  describe 'POST#send_to_draft' do
    it 'change status to draft' do
      post :send_to_draft, recipe_id: moderation_recipe.id
      moderation_recipe.reload
      expect(moderation_recipe.status).to eq "draft"
    end

    it 'redirect to admin index' do
      post :send_to_draft, recipe_id: moderation_recipe.id
      expect(response).to redirect_to admin_index_path
    end
  end
end
