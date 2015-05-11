require 'rails_helper'
require 'spec_helper'


feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    sign_in
    leave_review('so so', '3')
    sign_out
    sign_in_user2
    leave_review('Great!', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end

def sign_in
  visit '/users/sign_up'
  fill_in "Email", with: "anabia@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button 'Sign up'
end

def sign_in_user2
  visit '/users/sign_up'
  fill_in "Email", with: "eeshal@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button 'Sign up'
end


def sign_out
  visit '/'
  click_link 'Sign out'
end
