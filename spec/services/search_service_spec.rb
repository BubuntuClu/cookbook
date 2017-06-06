require 'rails_helper'
require_relative '../acceptance/acceptance_helper'

RSpec.describe Search do
  
  it 'calls search in recipe' do
    request = "recipe"
    escaped_request = ThinkingSphinx::Query.escape(request)
    expect(Recipe).to receive(:search).with( { conditions: { title: escaped_request, status: 2 } } ).and_call_original
    Search.run('recipe', request)
  end

  it 'calls search in ingredient' do
    request = "ingredient"
    escaped_request = ThinkingSphinx::Query.escape(request)
    expect(Ingredient).to receive(:search).with({ conditions: { name: escaped_request, status: 2 } } ).and_call_original
    Search.run('ingredient', request)
  end

  it 'calls search in user' do
    request = "user"
    escaped_request = ThinkingSphinx::Query.escape(request)
    expect(User).to receive(:search).with({ conditions: { email: escaped_request } } ).and_call_original
    Search.run('user', request)
  end

  it 'return empty array', type: :sphinx do
    question = create(:recipe)
    index
    expect(Search.run('recipe', 'afasf')).to eq []
  end
end
