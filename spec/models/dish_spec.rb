require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do
    it 'returns the total calorie count' do
      chef = Chef.create!(name: "Bron")
      dish = Dish.create!(name: "Seafood Pasta", description: 'Served with rolls', chef_id: chef.id)
      ingredient1 = dish.ingredients.create!(name: "Shrimp", calories: 500)
      ingredient2 = dish.ingredients.create!(name: "Pasta", calories: 750)

      expect(dish.total_calories).to eq(1250)
    end
  end
end