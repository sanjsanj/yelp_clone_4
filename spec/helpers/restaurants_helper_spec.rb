module RestaurantsHelper
  def add_a_restaurant name, description
    visit restaurants_path
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    fill_in 'Description', with: description
    click_button 'Create Restaurant'
  end
end
