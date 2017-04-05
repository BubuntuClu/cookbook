require_relative 'acceptance_helper'

feature 'Endless scrolling' do

  scenario 'any user can view recipes and scroll them', js: true do
    user = create(:user)
    recipes = create_list(:published_recipe, 27, user: user)
    visit root_path
    expect(page).to have_selector('.recipe', count: 20)
    page.execute_script "window.scrollBy(0,10000)"
    expect(page).to have_selector('.recipe', count: 27)
  end
end
