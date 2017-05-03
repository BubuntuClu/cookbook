require 'rails_helper'

RSpec.describe User do 
  describe 'associations' do
    it { should have_many(:recipes) }
    it { should have_many(:votes) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end
