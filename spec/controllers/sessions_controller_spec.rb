require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders new template if user is not logged in" do
      get :new
      expect(response).to render_template(:new)
    end
    it "redirects to home if user is already logged in" do
      Fabricate(:user)
      session[:user_id] = User.first.id
      get :new
      expect(response).to redirect_to(home_path)
    end
  end

  describe "POST create" do
    context "user has valid credentials" do
      let(:user) {Fabricate(:user, password: 'test')}
      before {post :create, {username: user.username, password: 'test'}}
      it "sets the session hash" do
        expect(session[:user_id]).to eq(user.reload.id)
      end
      it "redirects to home" do
        expect(response).to redirect_to(home_path)
      end
      it "displays a success message" do
        expect(flash[:success]).not_to be_blank
      end
    end
    context "user has invalid credentials" do
      let(:user) {Fabricate(:user, password: 'test')}
      before {post :create, {username: user.username, password: 'test123'}}
      it "has a blank session user hash" do
        expect(session[:user_id]).to be nil
      end
      it "renders new template" do
        expect(response).to render_template(:new)
      end
      it "displays an error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    let(:user) {Fabricate(:user, password: 'test')}
    before do
      session[:user_id] = user.id
      get :destroy
    end
    it "sets the session[:user_id] to nil" do
      expect(session[:user_id]).to be nil
    end
    it "redirects to root path" do
      expect(response).to redirect_to(root_path)
    end
    it "gives a message that the user is logged out" do
      expect(flash[:success]).not_to be_blank
    end
  end
end
