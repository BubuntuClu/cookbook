require_relative 'acceptance_helper'

feature 'Friends list', %q{
  In order to have a fast way to contact with interesting users
  As an authenticated user
  I want to be able to add/remove them in/from my friends list
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:recipe) { create(:published_recipe, user: user2) }

  scenario 'Authenticated user can add user to friends and u can find them on ur own page', js: true do
    sign_in(user)
    visit user_profile_path(recipe.user)
    expect(page).to have_link 'Добавить в друзья'
    click_on 'Добавить в друзья'
    expect(page).to have_link 'Убрать из друзей'

    click_on 'Profile'

    expect(page).to have_link recipe.user.email
    expect(page).to have_link 'Написать сообщение'
    expect(page).to have_link 'Убрать из друзей'
  end

  scenario 'Authenticated user can remove user from friends from another user page', js: true do
    sign_in(user)
    visit user_profile_path(recipe.user)
    expect(page).to have_link 'Добавить в друзья'
    click_on 'Добавить в друзья'
    expect(page).to have_link 'Убрать из друзей'
    click_on 'Убрать из друзей'
    expect(page).to have_link 'Добавить в друзья'
  end

  scenario 'Authenticated user can remove user from friends from hiw own page', js: true do
    sign_in(user)
    visit user_profile_path(recipe.user)
    expect(page).to have_link 'Добавить в друзья'
    click_on 'Добавить в друзья'
    click_on 'Profile'
    expect(page).to have_link 'Убрать из друзей'
    click_on 'Убрать из друзей'
    expect(page).to_not have_link recipe.user.email
  end
end
