require_relative 'acceptance_helper'

feature 'Create discussion', %q{
  In order to make some discussion under a recipe in comments
  As an user
  I want to be able to write an comment of a comments, in other words, start or continue discussion
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:recipe) { create(:published_recipe, user: user) }

  before do
    sign_in(user)
    visit recipe_path(recipe)
    title = recipe.title
    save_and_open_page
    give_an_recipe_comment
    click_on 'Sign out'
  end

  scenario 'Authenticated user start a discussion', js: true do
    sign_in(user2)
    visit recipe_path(recipe)
    within "#comment_discussions_#{recipe.comments.last.id}" do
      within '.new_discussion' do
        fill_in 'Body', with: 'ALL U WROTE IS WRONG!'
        click_on 'Дискутировать'
      end
    end

    within "#comment_discussions_#{recipe.comments.last.id}" do
      expect(page).to have_content user2.email
      expect(page).to have_content 'ALL U WROTE IS WRONG!'
    end
  end

  scenario 'Non-authenticated user try to creates comment' do
    visit recipe_path(recipe)
    expect(page).to_not have_link "Дискутировать"
  end

  private

  def give_an_recipe_comment
    within '.user_comments_panel' do
      fill_in 'Body', with: 'This is comment for recipe'
      click_on 'Оставить комментарий'
    end
  end
end
