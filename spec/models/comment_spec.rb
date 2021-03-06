require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:user) }
    it { should have_many(:discussions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body).with_message(/не может быть пустым/) }
  end
end
