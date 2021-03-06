require 'rails_helper'
require 'spec_helper'

feature 'restaurants' do
  context 'when no restaurants have been yet' do

    scenario 'Should display a prompt to add a new restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name:'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'a user must be logged in to create a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'Sign in with Facebook'
    end
  end

  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    sign_up
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
end

context 'viewing restaurants' do

  let!(:kfc) {Restaurant.create(name:'KFC')}

  scenario 'lets a user view a restaurant in a seperate page when user click on it' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq "/restaurants/#{kfc.id}"
  end
end

  context 'editing restaurant' do
    before { Restaurant.create name:  'KFC'}

    scenario 'Let a user edit a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: 'KFC'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end


## helper_methods
def sign_up
  visit ('/')
  click_link 'Sign up'
  fill_in 'Email', with: 'test@gmail.com'
  fill_in  'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
end








