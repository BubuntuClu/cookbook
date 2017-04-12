require 'rails_helper'

RSpec.describe StateController do 
  describe '.change_status' do
    let(:user) { create(:user) }
    let!(:draft_recipe) { create(:draft_recipe, user: user) }
    let!(:moderation_recipe) { create(:moderation_recipe, user: user) }

    it 'send to moderation' do
      StateController.change_status(draft_recipe.id, 'send_to_moderation')
      draft_recipe.reload
      expect(draft_recipe.status).to eq 'moderation'
    end

    it 'send to moderation' do
      StateController.change_status(moderation_recipe.id, 'send_to_publish')
      moderation_recipe.reload
      expect(moderation_recipe.status).to eq 'published'
    end

    it 'send to moderation' do
      StateController.change_status(moderation_recipe.id, 'send_to_draft', {body: 'test comment'} )
      moderation_recipe.reload
      expect(moderation_recipe.status).to eq 'draft'
      expect(moderation_recipe.comments.first.body).to eq 'test comment'
    end
  end
end
