require 'rails_helper'

RSpec.describe Recipe do 
  describe 'associations' do
    it { should have_many(:ingredients).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should accept_nested_attributes_for :ingredients }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title).with_message(/не может быть пустым/) }
    it { should validate_presence_of(:description).with_message(/не может быть пустым/) }
  end


  describe 'change_status' do
    let(:user) { create(:user) }
    let(:comments) { create_list(:comment,2) }
    let!(:draft_recipe) { create(:draft_recipe, user: user) }
    let!(:moderation_recipe) { create(:moderation_recipe, user: user) }
    let!(:recipe_with_comment) { create(:recipe, user: user, comments: comments) }

    it 'set to moderation' do
      draft_recipe.set_to_moderation
      draft_recipe.reload
      expect(draft_recipe.status).to eq 'moderation'
    end

    it 'set to published' do
      recipe_with_comment.set_to_publish
      expect(recipe_with_comment.status).to eq 'published'
      expect(recipe_with_comment.comments.count).to eq 0
    end

    it 'set to draft' do
      moderation_recipe.set_to_draft({body: 'test comment'})
      moderation_recipe.reload
      expect(moderation_recipe.status).to eq 'draft'
      expect(moderation_recipe.comments.first.body).to eq 'test comment'
      expect(moderation_recipe.comments.first.by_admin).to be true
    end
  end

  describe 'concern' do
    it_behaves_like 'votable'
  end

end
