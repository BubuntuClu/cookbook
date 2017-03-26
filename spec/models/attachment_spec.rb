require 'rails_helper'

RSpec.describe Attachment, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
  end

  describe 'validations' do
    it { should validate_presence_of :file }
    it { should validate_presence_of :type }
  end
end
