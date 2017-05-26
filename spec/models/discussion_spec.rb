require 'rails_helper'

RSpec.describe Discussion, type: :model do
  describe 'associations' do
    it { should belong_to(:comment) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body).with_message(/не может быть пустым/) }
  end
end
