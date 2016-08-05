require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "should assign @user to a new User" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
      expect(assigns(:user)).to be_new_record
    end
  end
  describe "POST create" do
    context "valid user registration input" do
      before {post :create, user: Fabricate.attributes_for(:user)}
      it "saves the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to sign in page" do
        expect(response).to redirect_to(sign_in_path)
      end
      it "sets a success message" do
        expect(flash[:success]).not_to be_blank
      end
    end
    context "invalid user registration input" do
      before {post :create, user: {username: "nopassword"}}
      it "doesn't save the user" do
        expect(User.count).to eq(0)
      end
      it "assigns @user" do
        expect(assigns(:user).username).to eq("nopassword")
      end
      it "renders new" do
        expect(response).to render_template :new
      end
      it "displays an error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
  describe "GET index" do
    context "logged in user" do
      before {logged_in_user}
      it "assigns @users" do
        Fabricate(:user)
        get :index
        expect(assigns[:users]).not_to be_blank
        expect(assigns[:users].first).to be_instance_of(User)
      end
    end
    it_behaves_like "user is not logged in" do
      let(:action) {get :index}
    end
  end

  describe "GET show" do
    context "logged in user" do
      it "assigns @user" do
        logged_in_user
        user = Fabricate(:user)
        get :show, id: user.id
        expect(assigns(:user)).to eq(user)
      end
    end
    it_behaves_like "user is not logged in" do
      let(:action) {get :show, id: Fabricate(:user).id}
    end
  end
end
