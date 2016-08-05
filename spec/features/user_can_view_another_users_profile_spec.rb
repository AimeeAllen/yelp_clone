require 'spec_helper'

feature "user can see a list of other users" do
  background do
    sign_in_user
  end
  scenario "visits user index page via header link" do
    visit home_path
    click_on "User Profiles"
    expect(page).to have_content("List of all Users:")
  end
end

feature "user can see another users profile page" do
  background do
    sign_in_user
    @user = Fabricate(:user)
  end
  scenario "username is clicked on from a review" do
    business = Fabricate(:business)
    review = Fabricate(:review, user: @user, business: business)
    visit business_path(business)
    click_on "user_#{@user.id}"
    expect(page).to have_content("Profile of: #{@user.username}")
  end
  scenario "user is selected from index page" do
    visit users_path
    click_on "user_#{@user.id}"
    expect(page).to have_content("Profile of: #{@user.username}")
  end
end
