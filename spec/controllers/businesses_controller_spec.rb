require 'spec_helper'

describe BusinessesController do
  describe "GET index" do
    let!(:business1) {Fabricate(:business)} #Need let! to evaluate before examples
    let!(:business2) {Fabricate(:business)}
    before {get :index}
    it "assigns @businesses" do
      expect(assigns(:businesses)).not_to be_blank
    end
    it "has @businesses as a collection of business objects" do
      expect(assigns(:businesses)).to match_array([business1, business2])
    end
  end

  describe "GET new" do
    it "assigns @business to a new object" do
      get :new
      expect(assigns(:business)).not_to be_blank
      expect(assigns(:business)).to be_new_record
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end

  describe "POST create" do
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

  describe "GET show" do
    it "assigns @business" do
      Fabricate(:business)
      get :show, id: Business.first
      expect(assigns(:business)).to be_instance_of(Business)
      expect(assigns(:business)).not_to be_new_record
    end
  end
end
