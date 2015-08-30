require 'rails_helper'

feature 'restaurants page' do
  include RestaurantsHelper

  before do
    visit restaurants_path
  end

  context 'when no restaurants exist' do
    scenario 'informs user that there are no restaurants' do
      expect(page).to have_content 'No restaurants yet'
    end

    scenario 'has a link to add a restaurant' do
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'when restaurants are added in the backend' do
    before do
      Restaurant.create name: 'Japanese Canteen'
      visit restaurants_path
    end

    scenario 'does not say that no restaurants exist' do
      expect(page).not_to have_content 'No restaurants yet'
    end

    scenario 'displays restaurant name' do
      expect(page).to have_content 'Japanese Canteen'
    end
  end

  context 'when adding a restaurant in the frontend' do
    scenario 'has a form to fill in' do
      click_link 'Add a restaurant'
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Description'
    end

    scenario 'takes user back to restaurants page' do
      add_a_restaurant 'Japanese Canteen', 'My favourite'
      expect(current_path).to eq restaurants_path
    end

    scenario 'shows the newly added restaurant' do
      add_a_restaurant 'Japanese Canteen', 'My favourite'
      expect(page).to have_content 'Japanese Canteen'
    end
  end

  context 'when clicking on a restaurant' do
    let!(:jcan) {Restaurant.create name: 'Japanese Canteen'}

    before do
      visit restaurants_path
      click_link 'Japanese Canteen'
    end

    scenario 'takes user to that restaurant\'s path' do
      expect(current_path).to eq "/restaurants/#{jcan.id}"
    end

    scenario 'lets user view the restaurant' do
      expect(page).to have_content 'Japanese Canteen'
    end
  end
end
