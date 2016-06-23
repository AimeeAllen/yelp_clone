require 'spec_helper'

feature "user can register" do
  background do
    visit root_path
    click_on "Register now"
  end
  scenario "user correctly registers" do
    fill_in "Username", with: Faker::Internet.user_name
    fill_in "Password", with: Faker::Internet.password
    click_on "register_button"
    expect(page).to have_content("You have successfully registered. Please sign in below")
    expect(page).to have_button("Sign in")
  end
  scenario "user tries to invalidly register" do
    fill_in "Username", with: Faker::Internet.user_name
    click_on "register_button"
    expect(page).to have_content("Please enter valid details below")
    expect(page).to have_content("Register")
    expect(page).to have_button("register_button")
  end
end

feature "alternative path to registration" do
  scenario "user clicks on Sign Up button in header" do
    visit root_path
    click_link "Sign Up"
    expect(page).to have_button("register_button")
  end
end