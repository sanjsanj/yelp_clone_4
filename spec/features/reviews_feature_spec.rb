require 'rails_helper'

feature 'reviewing' do
  include RestaurantsHelper

  before do
    add_a_restaurant
  end

  scenario 'allows user to leave a review using a form' do
    visit restaurants_path
    click_link 'Review Japanese Canteen'
    fill_in 'Thoughts', with: 'Amazing'
    select '5', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq restaurants_path
    expect(page).to have_content 'Amazing'
  end
end
