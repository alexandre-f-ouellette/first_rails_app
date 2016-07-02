require 'rails_helper'
require 'devise'

describe CommentsController, :type => :controller do
  let!(:product) { Product.create!(name: "Bike #400") }
  let!(:user) { User.create!(email: "test-email@example.org", password: "TestPassword123!") }
  let!(:admin_user) { User.create!(email: "test@example.org", password: "TestPassword123!", admin: true) }

  describe "POST #create" do
    context "User is signed in" do
        before do
          sign_in user
        end

      it "should create new comment and redirect to product" do
        expect {
          post :create, {
            product_id: product.id,
            comment: {
              user_id: user.id,
              body: "This is a review",
              rating: 5
            }
          }
        }.to change{ product.comments.count }.by(1)

        expect(response).to redirect_to product
      end

      it "should not create a comment when body is empty" do
        expect {
          post :create, {
            product_id: product.id,
            comment: {
              user_id: user.id,
              rating: 5
            }
          }
        }.to_not change{ product.comments.count }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to product
      end

      it "should not create a comment when rating is empty" do
        expect {
          post :create, {
            product_id: product.id,
            comment: {
              user_id: user.id,
              body: "This is a review"
            }
          }
        }.to_not change{ product.comments.count }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to product
      end
    end

    context "User is not signed in" do
      it "should not create a comment" do
        expect {
          post :create, {
            product_id: product.id,
            comment: {
              user_id: user.id,
              body: "This is a review",
              rating: 5
            }
          }
        }.to_not change{ product.comments.count }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "DELETE #destroy" do
    context "User is logged in" do
      before do
        sign_in user
      end

      let!(:comment) { Comment.create!(product_id: product.id, user_id: user.id, body: "Test comment", rating: 4) }

      it "should delete user's own comment and redirect to product" do
        expect {
          delete :destroy, product_id: product.id, id: comment.id
        }.to change { product.comments.count }.by(-1)

        expect(response).to redirect_to product
      end

      let!(:admin_comment) { Comment.create!(product_id: product.id, user_id: admin_user.id, body: "Test comment", rating: 4) }

      it "should not delete someone else's comment and redirect to product" do
        expect {
          delete :destroy, product_id: product.id, id: admin_comment.id
        }.to_not change { product.comments.count }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context "User is not logged in" do
      let!(:comment) { Comment.create!(product_id: product.id, user_id: admin_user.id, body: "Test comment", rating: 4) }

      it "should not delete comment" do
        expect {
          delete :destroy, id: comment.id, product_id: product.id
        }.to_not change{ product.comments.count }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/login'
      end
    end
  end
end
