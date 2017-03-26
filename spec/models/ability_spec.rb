require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, :all }
  end

  describe 'for user' do
    let(:user) { create :user }

    it { should be_able_to :manage, :all }
  end
  
end
