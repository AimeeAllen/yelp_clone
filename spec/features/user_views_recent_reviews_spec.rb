require 'spec_helper'

feature "user views recent reviews" do
  background {Fabricate(:business)}
  scenario "user sees reviews on business show page" do
    sign_in_user
    visit business_path(Business.first.id)
    expect(page).to have_content("User Reviews")
  end  
end
