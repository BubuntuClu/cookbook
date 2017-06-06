require_relative 'acceptance_helper'

feature 'User', %q{
  In order to be find an recipe or recipe by ingredient
  I want to be able to search
} do

  given!(:user) { create(:user) }
  given!(:recipe) { create(:published_recipe, user: user) }
  given!(:ingredients) { create_list(:ingredient, 2) }
  given!(:recipe_with_ingredient) { create(:published_recipe, user: user, ingredients: ingredients) }

  before do
    index
    visit root_path
  end

  scenario 'try to find recipe', js: true do
    make_search('recipe', recipe.title)
    expect(page).to have_content recipe.title
  end

  scenario 'try to find recipe by ingredient', js: true do
    make_search('ingredient', ingredients[1].name)
    expect(page).to have_content recipe_with_ingredient.title
  end

  scenario 'try to find user by email', js: true do
    make_search('user', user.email)
    expect(page).to have_content 'Пользователи'
    expect(page).to have_content user.email
  end

  scenario 'no result', js: true do
    make_search('recipe', 'asdasdasd')
    expect(page).to have_content 'Нет результатов поиска'
  end

  private 

  def make_search(type, text)
    select type, from: 'search_type'
    fill_in 'search', with: text
    click_on 'Искать'
  end
end
