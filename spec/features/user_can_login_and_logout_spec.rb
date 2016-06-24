require 'spec_helper'

feature "user tries to login" do
  scenario "user is already logged in" do
    sign_in_user
    visit sign_in_path
    expect(page).not_to have_link("header_login")
    expect(page).to have_current_path(home_path)
  end
  scenario "user has valid credentials" do
    user = Fabricate(:user)
    visit sign_in_path
    expect(page).not_to have_link("header_logout")
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("Welcome #{user.username}")
  end
  scenario "user has invalid credentials" do
    user = Fabricate(:user)
    visit sign_in_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password + "1"
    click_button "Sign in"
    expect(page).to have_button("sign_in_button")
    expect(page).to have_link("header_sign_up")
    expect(page).to have_link("header_login")
    expect(page).not_to have_link("header_logout")
  end
end

feature "user tries to logout" do
  scenario "user clicks logout button" do
    sign_in_user
    visit home_path
    click_on("header_logout")
    expect(page).to have_current_path(root_path)
    expect(page).to have_link("header_sign_up")
    expect(page).to have_link("header_login")
    expect(page).not_to have_link("header_logout")
  end
end