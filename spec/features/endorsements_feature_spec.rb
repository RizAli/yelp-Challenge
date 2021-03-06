require 'rails_helper'

feature 'endorsing reviews' do

  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review which updates the review endorse count', js: true do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Great'
    click_button 'Leave Review'
    click_link 'Endorse KFC'
    expect(page).to have_content('1 endorsement')
  end

  it 'a user can endorse a review, which increments the endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content("1 endorsement")
  end
end





