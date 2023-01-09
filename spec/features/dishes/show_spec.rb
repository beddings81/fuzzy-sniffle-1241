require 'rails_helper'

RSpec.describe "dish's show page" do
  it 'displays its name, description, and its ingredients' do
    chef = Chef.create!(name: "Bron")
    dish = Dish.create!(name: "Seafood Pasta", description: 'Served with rolls', chef_id: chef.id)
    ingredient1 = dish.ingredients.create!(name: "Shrimp", calories: 500)
    ingredient2 = dish.ingredients.create!(name: "Pasta", calories: 750)

    visit dish_path(dish)

    expect(page).to have_content("Seafood Pasta")
    expect(page).to have_content("Description: Served with rolls")
    expect(page).to have_content("Made by Chef Bron")

    within("#ingredients") do
      expect(page).to have_content("Shrimp")
      expect(page).to have_content("Pasta")
    end
  end

  it 'displays the total calorie count' do
    chef = Chef.create!(name: "Bron")
    dish = Dish.create!(name: "Seafood Pasta", description: 'Served with rolls', chef_id: chef.id)
    ingredient1 = dish.ingredients.create!(name: "Shrimp", calories: 500)
    ingredient2 = dish.ingredients.create!(name: "Pasta", calories: 750)

    visit dish_path(dish)

    expect(page).to have_content("Total Calories: 1250")
  end
end