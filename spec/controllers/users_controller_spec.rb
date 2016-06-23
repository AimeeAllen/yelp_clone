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
end
