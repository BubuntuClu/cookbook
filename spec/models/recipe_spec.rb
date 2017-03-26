require 'rails_helper'

RSpec.describe Recipe do 
  describe 'associations' do
    it { should have_many(:ingredients).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }
    it { should accept_nested_attributes_for :ingredients }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

end
