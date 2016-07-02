require 'rails_helper'

describe UsersController, :type => :controller do

  let(:user) { User.create!(email: "test-email@example.org", password: "TestPassword123!") }
  let(:user2) { User.create!(email: "tom@example.org", password: "13245679") }

  describe "GET #show" do
    context "User is logged in" do
      before do
        sign_in user
      end

      it "loads correct user details" do
        get :show, id: user.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
      end

      it "should redirect to root_path when viewing another user's details" do
        get :show, id: user2.id
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context "No user is logged in" do
      it "redirects to login page" do
        get :show, id: user.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #index" do
    context "User is logged in" do
      before do
        sign_in user
      end

      it "loads the users' page" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "User is not logged in" do
      it "loads the users' page" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end
end
