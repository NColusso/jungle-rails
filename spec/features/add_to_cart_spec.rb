require 'rails_helper'

RSpec.feature "Visitor can add item to cart", type: :feature, js:true do
  
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They can add an item to cart and cart total will increase by one" do

    visit root_path

    expect(page).to have_css 'a', text: "My Cart (0)"
    save_screenshot

    find(:button, 'Add', match: :first).click

    expect(page).to have_css 'a', text: "My Cart (1)"

    save_screenshot
  end
end
