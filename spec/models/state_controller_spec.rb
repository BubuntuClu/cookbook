require 'rails_helper'

RSpec.describe StateController do 
  describe '.change_status' do
    let(:user) { create(:user) }
    let!(:draft_recipe) { create(:draft_recipe, user: user) }
    let!(:moderation_recipe) { create(:moderation_recipe, user: user) }
    let!(:recipe_with_comment) { create(:recipe, user: user, comments: (comments, user_comment)) }

    it 'send to moderation' do
      StateController.change_status(draft_recipe.id, 'send_to_moderation')
      draft_recipe.reload
      expect(draft_recipe.status).to eq 'moderation'
    end

    it 'send to moderation' do
      StateController.change_status(recipe_with_comment.id, 'send_to_publish')
      recipe_with_comment.reload
      expect(recipe_with_comment.status).to eq 'published'
      expect(recipe_with_comment.comments.count).to eq 1
    end

    it 'send to moderation' do
      StateController.change_status(moderation_recipe.id, 'send_to_draft', {body: 'test comment'} )
      moderation_recipe.reload
      expect(moderation_recipe.status).to eq 'draft'
      expect(moderation_recipe.comments.first.body).to eq 'test comment'
      expect(moderation_recipe.comments.first.by_admin).to be true
    end
  end
end
