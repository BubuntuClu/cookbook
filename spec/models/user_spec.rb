require 'rails_helper'

RSpec.describe User do 
  describe 'associations' do
    it { should have_many(:recipes) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end
