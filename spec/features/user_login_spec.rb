require 'rails_helper'

RSpec.feature "User can log in and they are taken to the home page", type: :feature, js:true do
  
  before :each do
    @user = User.create!(name: "Jane Doe", email: 'jane@gmail.com', password: 'jane11', password_confirmation: 'jane11')

  end
  scenario "They click on a specific product and see their details" do

    visit root_path

    save_screenshot

    find(:link, 'Login').click

    page.fill_in 'email', with: 'jane@gmail.com'
    page.fill_in 'password', with: 'jane11'
    
    save_screenshot

    find('body > main > form > input.btn.btn-primary').click

    expect(page).to have_css 'span', text: "Signed in as: Jane Doe"
    
    save_screenshot

  end
end
