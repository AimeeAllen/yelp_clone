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
end
