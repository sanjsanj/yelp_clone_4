require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let!(:restaurant) { Restaurant.new name: 'Japanese Canteen' }

  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it { should validate_uniqueness_of(:name) }

  it 'has a name' do
    expect(restaurant.name).to eq 'Japanese Canteen'
  end
end
