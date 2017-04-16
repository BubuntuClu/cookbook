require_relative 'acceptance_helper'

feature 'Vote for recipe', %q{
  In order to vote for good recipe
  As an authenticated user
  I want to be able to vote for recipe
} do

  given(:user) { create(:user) }
  given!(:recipe) { create(:published_recipe, user: user) }

  scenario 'Non-authenticated user try to vote for recipe' do
    visit recipe_path(recipe)
    expect(page).to_not have_link 'Проголосовать "ЗА"'
    expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
  end

  describe 'Authenticated user' do
    describe 'Author' do

      before do
        sign_in user
        visit recipe_path(recipe)
      end

      scenario 'Author cant see votes links for his recipe' do
        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to_not have_link 'Забрать голос'
      end
    end  

    describe 'Not Author' do

      before do
        user2 = create(:user)
        sign_in user2
        visit recipe_path(recipe)
      end

      scenario 'Not author votes up for not his recipe', js: true do
        click_on 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: 1'
      end

      scenario 'Not author votes down for not his recipe', js: true do
        click_on 'Проголосовать "ПРОТИВ"'
        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: -1'
      end

      scenario 'Not author votes and then unvotes for not his recipe', js: true do
        click_on 'Проголосовать "ПРОТИВ"'
        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: -1'

        click_on 'Забрать голос'
        expect(page).to have_link 'Проголосовать "ЗА"'
        expect(page).to have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to_not have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: 0'
      end

      scenario 'Not author tryes to vote second time for same recipe', js: true do
        click_on 'Проголосовать "ПРОТИВ"'
        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: -1'
        visit recipe_path(recipe)

        expect(page).to_not have_link 'Проголосовать "ЗА"'
        expect(page).to_not have_link 'Проголосовать "ПРОТИВ"'
        expect(page).to have_link 'Забрать голос'
        expect(page).to have_text 'Рейтинг блюда: -1'
      end

      describe 'check user rating after recipe vote' do

        scenario 'rating increased' do
          click_on 'Проголосовать "ЗА"'
          visit user_profile_path(recipe.user)
          expect(page).to have_text 'Рейтинг: 0.5'
        end

        scenario 'rating decreased' do
          click_on 'Проголосовать "ПРОТИВ"'
          visit user_profile_path(recipe.user)
          expect(page).to have_text 'Рейтинг: -0.5'
        end
      end
    end 
  end
end
