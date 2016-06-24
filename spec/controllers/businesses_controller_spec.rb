require 'spec_helper'

describe BusinessesController do
  describe "GET index" do
    context "logged in user" do
      let!(:business1) {Fabricate(:business)} #Need let! to evaluate before examples
      let!(:business2) {Fabricate(:business)}
      before do
        logged_in_user
        get :index
      end
      it "assigns @businesses" do
        expect(assigns(:businesses)).not_to be_blank
      end
      it "has @businesses as a collection of business objects" do
        expect(assigns(:businesses)).to match_array([business1, business2])
      end
    end
    it_behaves_like "user is not logged in" do
      let(:action) {get :index}
    end
  end

  describe "GET new" do
    it "assigns @business to a new object when user is logged in" do
      logged_in_user
      get :new
      expect(assigns(:business)).not_to be_blank
      expect(assigns(:business)).to be_new_record
      expect(assigns(:business)).to be_instance_of(Business)
    end
    it_behaves_like "user is not logged in" do
      let(:action) {get :new}
    end
  end

  describe "POST create" do
    context "logged in user" do
      before {logged_in_user}
      context "with valid input" do
        before {post :create, business: Fabricate.attributes_for(:business)}
        it "redirects to business show" do
          expect(response).to redirect_to(business_path(Business.first))
        end
        it "saves the business" do
          expect(Business.count).to eq(1)
        end
        it "displays a success message" do
          expect(flash[:success]).not_to be_blank
        end
      end
      context "with invalid input" do
        before {post :create, business: {description: "No business name"}}
        it "renders the new template again" do
          expect(response).to render_template(:new)
        end
        it "does not save the business" do
          expect(Business.count).to eq(0)
        end
        it "displays an error message" do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
    it_behaves_like "user is not logged in" do
      let(:action) {post :create, business: Fabricate.attributes_for(:business)}
    end
  end

  describe "GET show" do
    it "assigns @business with logged in user" do
      logged_in_user
      Fabricate(:business)
      get :show, id: Business.first
      expect(assigns(:business)).to be_instance_of(Business)
      expect(assigns(:business)).not_to be_new_record
    end
    it_behaves_like "user is not logged in" do
      let(:action) do
        Fabricate(:business)
        get :show, id: Business.first
      end
    end
  end
end
