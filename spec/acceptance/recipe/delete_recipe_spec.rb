require_relative '../acceptance_helper'

feature 'Recipe deleting', %q{
  In order to delete a recipe
  As an author of recipe
  I want to delete my recipe
} do
  
  given(:user) { create(:user) }
  given!(:draft_recipe) { create(:draft_recipe, user: user) }
  given!(:published_recipe) { create(:published_recipe, user: user) }
  given!(:moderation_recipe) { create(:moderation_recipe, user: user) }

  scenario 'Non-authenticated user try to edit recipe' do
    visit recipe_path(draft_recipe)
    expect(page).to_not have_link 'Удалить'
  end

  describe 'Authenticated user' do
    describe 'Author' do

      before do
        sign_in user
      end

      scenario 'tryes to delete his recipe that no published' do
        visit recipe_path(draft_recipe)
        click_on 'Удалить'
        expect(current_path).to eq user_profile_path(user)
        expect(page).to_not have_content draft_recipe.title
      end

      scenario 'tryes to delete his recipe that is published' do
        visit recipe_path(published_recipe)
        expect(page).to_not have_content 'Удалить'
        expect(page).to have_content 'Опубликован'
      end

      scenario 'tryes to delete his recipe that is on moderation' do
        visit recipe_path(moderation_recipe)
        expect(page).to_not have_content 'Удалить'
        expect(page).to have_content 'На модерации'
      end
    end
  end
end
