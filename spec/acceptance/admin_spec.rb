require_relative 'acceptance_helper'

feature 'Admin function' do
  context 'Not admin' do
    given(:user) { create(:user) }

    scenario 'Not-user cant see "Admin panel"' do
      sign_in(user)
      expect(page).to_not have_content('Admin panel')
    end

    scenario 'Guest cant see "Admin panel"' do
      visit root_path
      expect(page).to_not have_content('Admin panel')
    end
  end

  context 'Admin' do
    given(:admin) { create(:admin) }
    given(:user) { create(:user) }
    given!(:recipe) { create(:moderation_recipe, user: user) }

    scenario 'Admin can publish right recipes' do 
      sign_in(admin)
      click_on 'Admin panel'
      click_on "#{recipe.title}"
      click_on 'Опубликовать рецепт'
     
      expect(page).to_not have_content '"#{recipe.title}"'
      visit root_path
      expect(page).to have_content 'this is moderation_recipe'
    end

    scenario 'Admin can return recipe with comment' do 
      sign_in(admin)
      click_on 'Admin panel'
      click_on "#{recipe.title}"
      fill_in 'Body', with: 'i return this recipe because i can'
      click_on "Вернуть рецепт на доработку"
      expect(page).to_not have_content '"#{recipe.title}"'
      click_on 'Sign out'
      sign_in(user)
      visit recipe_path(recipe)
      expect(page).to have_content 'i return this recipe because i can'
    end
  end
end
