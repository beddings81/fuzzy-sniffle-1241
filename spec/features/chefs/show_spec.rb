require 'rails_helper'

RSpec.describe 'chefs show page' do
  it 'displays the name and its dishes' do
    chef = Chef.create!(name: "Bron")
    chef2 = Chef.create!(name: "Kobe")
    dish = Dish.create!(name: "Seafood Pasta", description: 'Served with rolls', chef_id: chef.id)
    dish2 = Dish.create!(name: "Grilled Chicken", description: 'Served with bbq sauce', chef_id: chef.id)
    dish3 = Dish.create!(name: "Loaded Baked Potato", description: 'Served with butter', chef_id: chef2.id)

    visit chef_path(chef)

    expect(page).to have_content("Bron")

    within("#dishes") do
      expect(page).to have_content("Seafood Pasta")
      expect(page).to have_content("Grilled Chicken")
      expect(page).to_not have_content("Loaded Baked Potato")
    end
  end

  it 'contains a form to add an exisiting dish' do
    chef = Chef.create!(name: "Bron")
    chef2 = Chef.create!(name: "Kobe")
    dish = Dish.create!(name: "Seafood Pasta", description: 'Served with rolls', chef_id: chef.id)
    dish2 = Dish.create!(name: "Grilled Chicken", description: 'Served with bbq sauce', chef_id: chef.id)
    dish3 = Dish.create!(name: "Loaded Baked Potato", description: 'Served with butter', chef_id: chef2.id)

    visit chef_path(chef)

    within("#dishes") do
      expect(page).to_not have_content("Loaded Baked Potato")
    end

    expect(page).to have_field "dish_id"
    
    fill_in('dish_id', with: "#{dish3.id}")

    click_button 'Submit'

    expect(current_path).to eq(chef_path(chef))

    within("#dishes") do
      expect(page).to have_content("Loaded Baked Potato")
    end
  end
end