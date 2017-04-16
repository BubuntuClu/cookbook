require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to give an comment
  As an user
  I want to be able to write an comment
} do
  given(:user) { create(:user) }
  given!(:recipe) { create(:published_recipe, user: user) }

  scenario 'Authenticated user creates comment for recipe', js: true do
    sign_in(user)
    visit recipe_path(recipe)
    title = recipe.title
    give_an_recipe_comment
    expect(current_path).to eq recipe_path(recipe)
    
    within '.user_comments' do
      expect(page).to have_content 'This is comment for recipe'  
    end
  end

  scenario 'Non-authenticated user try to creates comment' do
    visit recipe_path(recipe)
    expect(page).to_not have_link "Оставить комментарий"
  end

  private

  def give_an_recipe_comment
    within '.user_comments_panel' do
      fill_in 'Body', with: 'This is comment for recipe'
      click_on 'Оставить комментарий'
    end
  end
end
