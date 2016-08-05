require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let!(:business) {Fabricate(:business)}
    context "logged in user" do
      before do
        logged_in_user
      end
      context "valid input" do
        before {post :create, {business_id: business.id, review: {body: Faker::Lorem.sentence}}}
        it "saves the review" do
          expect(Review.find_by(user_id: session[:user_id], business: business)).not_to be_nil
        end
        it "redirects to the business show page" do
          expect(response).to redirect_to business_path(business)
        end
        it "displays a success message" do
          expect(flash[:success]).not_to be_blank
        end
      end
      context "invalid input" do
        before {post :create, {business_id: business.id, review: {body: ""}}}
        it "renders the business show page" do
          expect(response).to render_template "businesses/show"
        end
        it "displays an error message" do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
    it_behaves_like "user is not logged in" do
      let(:action) {post :create, {business_id: business.id, review: {body: Faker::Lorem.sentence}}}
    end
  end
end
