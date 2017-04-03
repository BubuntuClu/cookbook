require_relative '../acceptance_helper'

feature 'Recipe deleting', %q{
  In order to delete a recipe
  As an author of recipe
  I want to delete my recipe
} do
  
  given(:user) { create(:user) }
  given!(:recipe) { create(:recipe, user: user) }

  scenario 'Non-authenticated user try to edit recipe' do
    visit recipe_path(recipe)
    expect(page).to_not have_link 'Удалить'
  end

  describe 'Authenticated user' do
    describe 'Author' do

      before do
        sign_in user
        visit recipe_path(recipe)
      end

      scenario 'tryes to delete his recipe' do
        click_on 'Удалить'
        expect(current_path).to eq recipes_path
        expect(page).to_not have_content recipe.title
      end
    end

    # scenario 'tryes to edit not his recipe' do
    #   user2 = create(:user)
    #   sign_in(user2)
    #   visit recipe_path(recipe)
    #   expect(page).to_not have_link 'Удалить'
    # end
  end
end
