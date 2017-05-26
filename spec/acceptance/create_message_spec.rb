require_relative 'acceptance_helper'

feature 'Create message', %q{
  In order to contact with author of recipe
  As an authenticated user
  I want to be able to message him
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }

  scenario 'User can see what I writed', js: true do
    sign_in(user)
    visit user_profile_path(user2)

    click_on 'Написать сообщение'
    fill_in 'Body', with: 'Какой-то осмысленный текст'
    click_on 'Написать сообщение'
    within '.message' do
      expect(page).to have_content 'Я'
      expect(page).to have_content 'Какой-то осмысленный текст'
    end

    click_on 'Sign out'
    sign_in(user2)
    visit user_profile_path(user)
    click_on 'Написать сообщение'
    within '.message' do
      expect(page).to have_content user.email
      expect(page).to have_content 'Какой-то осмысленный текст'
    end
  end

  context "multiple sessions" do
    scenario "message appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit user_profile_path(user2)
        click_on 'Написать сообщение'
      end

      Capybara.using_session('user2') do
        sign_in(user2)
        visit user_profile_path(user)
        click_on 'Написать сообщение'      
      end

      Capybara.using_session('user') do
        fill_in 'Body', with: 'Какой-то осмысленный текст'
        click_on 'Написать сообщение'

        within '.message' do
          expect(page).to have_content 'Я'
          expect(page).to have_content 'Какой-то осмысленный текст'
        end
      end

      Capybara.using_session('user2') do
        expect(page).to have_content user.email
        expect(page).to have_content 'Какой-то осмысленный текст'
      end
    end
  end
end
