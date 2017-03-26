require_relative '../acceptance_helper'

feature 'Recipe editing', %q{
  In order to fix my misstake
  As an author of recipe
  I want to edit my recipe
} do
  
  given(:user) { create(:user) }
  given!(:recipe) { create(:recipe, user: user) }

  scenario 'Non-authenticated user try to edit recipe' do
    visit recipe_path(recipe)
    expect(page).to_not have_link 'Редактировать'
  end

  describe 'Authenticated user' do
    describe 'Author' do

      before do
        sign_in user
        visit recipe_path(recipe)
      end

      scenario 'tryes to edit his recipe' do
        click_on 'Редактировать'
        fill_in 'Title', with: 'proverka'
        click_on 'Обновить рецепт'
        expect(current_path).to eq recipe_path(recipe)
        expect(page).to have_content 'proverka'
      end
    end

    # scenario 'tryes to edit not his recipe' do
    #   user2 = create(:user)
    #   sign_in(user2)
    #   visit recipe_path(recipe)
    #   expect(page).to_not have_link 'Обновить рецепт'
    # end
  end
end
