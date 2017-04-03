require_relative 'acceptance_helper'

feature 'Endless scrolling' do

  scenario 'any user can view recipes and scroll them', js: true do
    recipes = create_list(:recipe, 27)
    visit recipes_path
    expect(page).to have_selector('.recipe', count: 20)
    page.execute_script "window.scrollBy(0,10000)"
    expect(page).to have_selector('.recipe', count: 27)
  end
end
