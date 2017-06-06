require_relative '../acceptance_helper'

feature 'Create recipe', %q{
  In order to share knowledge in cook
  As an authenticated user
  I want to be able to create recipe
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates recipe', js: true do
    sign_in(user)
    click_on 'Создать рецепт'

    fill_in 'Title', with: 'Test title'
    attach_file 'file', "#{Rails.root}/spec/spec_helper.rb"
    fill_in 'Description', with: 'Text description'

    click_on 'Добавить ингридиент'
    within page.all('.nested-fields')[0] do 
      fill_in 'Name', with: 'first ingredient'
      fill_in 'Measure', with: '1 glass'
      fill_in 'Price', with: '13.3'
    end

    within page.all('.nested-fields')[1] do 
      fill_in 'Name', with: 'second ingredient'
      fill_in 'Measure', with: '3 spoons'
      fill_in 'Price', with: '10'
    end
    click_on 'Оформить рецепт'

    expect(current_path).to eq recipe_path(Recipe.last.slug)
    expect(page).to have_content 'Test title'
    expect(page).to have_content 'Text description'
    expect(page).to have_content 'first ingredient'
    expect(page).to have_content '1 glass'
    expect(page).to have_content 'second ingredient'
    expect(page).to have_content '3 spoons'
    expect(page).to have_content '13.3'
    expect(page).to have_content '10'
    expect(page).to have_content '23.3'
  end

  scenario 'Authenticated user creates invalid recipe' do
    sign_in(user)
    click_on 'Создать рецепт'
    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    click_on 'Создать рецепт'
    within '.recipe_title' do
      expect(page).to have_content 'не может быть пустым'
    end
    within '.recipe_description' do
      expect(page).to have_content 'не может быть пустым'
    end
    expect(current_path).to eq recipes_path
  end

  scenario 'Non-authenticated user try to creates recipe' do
    expect(page).to_not have_content 'Создать рецепт'
  end


end
