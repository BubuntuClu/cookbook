require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, :all }
  end

  describe 'common ability' do
    let(:user) { create(:user) }

    it { should be_able_to :manage, Recipe }
    it { should be_able_to :manage, Ingredient }
    it { should be_able_to :manage, Comment }
    it { should be_able_to :manage, Vote }
    it { should be_able_to :manage, Attachment }
  end

  context 'users ability' do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let(:draft_recipe) { create(:draft_recipe, user: user) }
    let(:moderation_recipe) { create(:moderation_recipe, user: user) }

    describe 'simple user' do
      let(:user) { create(:user) }
      let(:draft_recipe) { create(:draft_recipe, user: user) }
      let(:moderation_recipe) { create(:moderation_recipe, user: user) }

      it { should be_able_to :set_to_moderation, draft_recipe, user: user }
      it { should_not be_able_to :set_to_publish, moderation_recipe, user: user }
      it { should_not be_able_to :set_to_draft, moderation_recipe, user: user }
    end

    describe 'admin user' do
      let(:user) { create(:admin) }
      let(:draft_recipe) { create(:draft_recipe, user: create(:user)) }
      let(:moderation_recipe) { create(:moderation_recipe, user: create(:user)) }
      
      it { should_not be_able_to :set_to_moderation, draft_recipe, user: user }
      it { should be_able_to :set_to_publish, moderation_recipe, user: user }
      it { should be_able_to :set_to_draft, moderation_recipe, user: user }
    end 
  end 
end
