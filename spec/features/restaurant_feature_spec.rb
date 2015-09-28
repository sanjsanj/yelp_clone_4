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

  context 'when adding a restaurant' do
    scenario 'has a form to fill in' do
      click_link 'Add a restaurant'
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Description'
    end

    scenario 'takes user back to restaurants page' do
      add_a_restaurant
      expect(current_path).to eq restaurants_path
    end

    scenario 'shows the newly added restaurant\'s name' do
      add_a_restaurant
      expect(page).to have_content 'Japanese Canteen'
    end

    scenario 'is not valid unless it has a unique name' do
      add_a_restaurant
      add_a_restaurant
      expect(page).to have_content 'error'
    end
  end

  context 'when viewing a restaurant' do
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

  context 'when updating a restaurant' do
    before do
      add_a_restaurant
    end

    scenario 'takes user back to restaurants page' do
      expect(current_path).to eq restaurants_path
    end

    scenario 'restaurant updates correctly' do
      click_link 'Edit Japanese Canteen'
      fill_in 'Name', with: 'Japanese Canteen Liverpool st'
      fill_in 'Description', with: 'Still my favourite'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Japanese Canteen Liverpool st Still my favourite'
    end
  end

  context 'when deleting a restaurant' do
    before do
      add_a_restaurant
    end

    scenario 'the restaurant gets deleted' do
      click_link 'Delete Japanese Canteen'
      expect(page).to have_content 'No restaurants yet'
    end

    scenario 'informs user that restaurant was deleted' do
      click_link 'Delete Japanese Canteen'
      expect(page).to have_content 'Japanese Canteen deleted successfully'
    end
  end
end
