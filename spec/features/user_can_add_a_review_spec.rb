require 'spec_helper'

feature "user can add a review for a business" do
  background do
    sign_in_user
    Fabricate(:business)
    @review_text = Faker::Lorem.sentence
  end
  scenario "user successfully adds a review on a business" do
    visit business_path(Business.first)
    expect(page).to have_content("Review this business")
    fill_in :review_body, with: @review_text
    click_on "Submit"
    expect(page).to have_content(@review_text)
    expect(page).to have_content("Thank you for your review on")
  end
end