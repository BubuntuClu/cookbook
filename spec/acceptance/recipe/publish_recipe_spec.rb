require_relative '../acceptance_helper'

feature 'Recipe publishing', %q{
  In order to show my recipe
  As an author of recipe
  I want to publish my recipe
} do
  
  given(:user) { create(:user) }
  given!(:recipe) { create(:recipe, user: user) }

  scenario 'tryes to edit his recipe', js: true do
    sign_in user
    visit recipe_path(recipe)
    click_on 'Отправить на модерацию'
    expect(page).to have_content 'На модерации'
  end

end
