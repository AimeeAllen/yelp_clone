require 'spec_helper'

feature "user can add a business" do
  background do
    sign_in_user
    visit home_path
    click_on "+ Add a New Business"
  end
  scenario "user successfully adds a new business" do
    fill_in "Business Name", with: Faker::Lorem.word
    fill_in "Description of Business", with: Faker::Lorem.paragraph
    click_on "Add Business"
    expect(page).to have_current_path("/businesses/#{Business.first.id}")
  end
  scenario "user incorrectly fills in new business form" do
    fill_in "Description of Business", with: Faker::Lorem.paragraph
    click_on "Add Business"
    expect(page).to have_content("Add a New Business")
    expect(page).to have_content("Description of Business")
    expect(page).to have_content("Please fix your input and resubmit") # testing flash msg
  end
end