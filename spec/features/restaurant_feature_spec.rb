require 'rails_helper'

feature 'restaurants page' do
  before do
    visit restaurants_path
  end

  context 'when no restaurants exist' do
    scenario 'informs user that there are no restaurants' do
      expect(page).to have_content 'No restaurants yet'
    end

    scenario 'displays a prompt to add a restaurant' do
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'when restaurants are added to the backend' do
    before do
      Restaurant.create name: 'KFC'
      visit restaurants_path
    end

    scenario 'does not say that no restaurants exist' do
      expect(page).not_to have_content 'No restaurants yet'
    end

    scenario 'displays restaurant name' do
      expect(page).to have_content 'KFC'
    end
  end
end
