require 'rails_helper'

describe ProductsController, :type => :controller do
  let(:product1) { FactoryGirl.create(:product) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }
  let(:comment) { FactoryGirl.build(:comment) }

  describe "GET #index" do
    it "should render the page properly" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(assigns(:products)).to eq(Product.all)
    end

    context "Search term is entered" do
      it "should render the page and show only results of query" do
        get :index, q: "Bike"
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:products)).to_not eq(Product.all)
      end
    end
  end

  describe "GET #show" do
    it "should render the page properly" do
      get :show, :id => product1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(assigns(:comments)).to all(have_attributes(:product_id => product1.id))
    end
  end

  describe "POST #create" do
    context "User is not logged in" do
      it "should not create the product" do
        expect {
          post :create, {
            product: {
              name: "Bicycle 4"
            }
          }
        }.to_not change{ Product.count }
        expect(response).to redirect_to '/login'
      end
    end

    context "User is logged in" do
      before do
        sign_in user
      end

      it "should not create the product" do
        expect {
          post :create, {
            product: {
              name: "Bicycle 4"
            }
          }
        }.to_not change{ Product.count }
        expect(response).to redirect_to root_path
      end
    end

    context "Admin user is logged in" do
      before do
        sign_in admin_user
      end

      it "should create the product" do
        expect {
          post :create, {
            product: {
              name: "Bicycle 4"
            }
          }
        }.to change{ Product.count }.by(1)
        expect(response).to redirect_to(assigns[:product])
      end
    end
  end

  describe "PATCH #edit" do
    context "User is not logged in" do
      it "should not update the product and redirect to login" do
        patch :update, id: product1.id, product: { name: "Bicycle 4" }
        expect(product1.reload.name).to_not eq('Bicycle 4')
        expect(response).to redirect_to('/login')
      end
    end

    context "User is logged in" do
      before do
        sign_in user
      end

      it "should not update the product and redirect to root" do
        patch :update, id: product1.id, product: { name: "Bicycle 4" }
        expect(product1.reload.name).to_not eq('Bicycle 4')
        expect(response).to redirect_to(root_path)
      end
    end

    context "Admin user is logged in" do
      before do
        sign_in admin_user
      end

      it "should update the product and redirect to its page" do
        patch :update, id: product1.id, product: { name: "Bicycle 4" }
        expect(product1.reload.name).to eq('Bicycle 4')
        expect(response).to redirect_to(product_path(product1.id))
      end
    end
  end

  describe "DELETE #destroy" do
    context "User is not logged in" do
        let!(:product2) { Product.create!(name: "Bicycle #2", description: "Awesome bicycle") }

      it "should not delete the product and redirect to login" do
        expect {
          delete :destroy, id: product2.id
        }.to_not change { Product.count}

        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/login'
      end
    end

    context "User is logged in" do
      before do
        sign_in user
      end

        let!(:product2) { Product.create!(name: "Bicycle #2", description: "Awesome bicycle") }

      it "should not delete the product and redirect to root" do
        expect {
          delete :destroy, id: product2.id
        }.to_not change { Product.count}

        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context "Admin user is logged in" do
      before do
        sign_in admin_user
      end

        let!(:product2) { Product.create!(name: "Bicycle #2", description: "Awesome bicycle") }

      it "should destroy the product and redirect to products page" do
        expect {
          delete :destroy, id: product2.id
        }.to change { Product.count}.by(-1)

        expect(response).to redirect_to products_path
      end
    end
  end
end

