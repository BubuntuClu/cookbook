require_relative '../acceptance_helper'

feature 'Recipe editing', %q{
  In order to fix my misstake
  As an author of recipe
  I want to edit my recipe
} do
  
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:recipe) { create(:recipe, user: user) }
  given(:comments) { create_list(:comment, 2) }
  given!(:recipe_with_comment) { create(:recipe, user: user, comments: comments) }

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

    context 'Comments' do
      scenario 'Author sees the comment from admin' do
        sign_in user
        visit recipe_path(recipe_with_comment)
        expect(page).to have_content 'Comment from admin'
      end

      scenario 'Other users cant see the comment from admin' do
        sign_in user2
        visit recipe_path(recipe_with_comment)
        expect(page).to_not have_content 'Comment from admin'
      end
    end
  end
end
