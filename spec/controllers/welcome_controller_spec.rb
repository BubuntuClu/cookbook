require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET #search' do
    it 'render search template' do
      get :search, params: { search_type:'recipe', search: 'recipe' }
      expect(response).to render_template :search
    end

    it 'answer on request' do
      expect(controller).to receive(:search)
      get :search, params: { search_type:'recipe', search: 'recipe' }
      expect(response).to be_successful
    end

    it 'calls search' do
      expect(Search).to receive(:run).with('recipe', 'recipe')
      Search.run('recipe', 'recipe')
    end
  end
end
