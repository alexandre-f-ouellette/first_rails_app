require 'rails_helper'

describe Comment do
  context "when creating a comment for a product" do
    before do
      @product = Product.create!(name: "Bicycle #100")
      @user = User.create!(email: "test-email@example.org", password: "TestPassword123!")
    end

    it "is not valid when body is not present" do
      expect(Comment.new(user: @user, product: @product, rating: 5)).not_to be_valid
    end

    it "is not valid when user is not present" do
      expect(Comment.new(body: "Amazing bicycle", product: @product, rating: 5)).not_to be_valid
    end

    it "is not valid when product is not present" do
      expect(Comment.new(body: "Amazing bicycle", user: @user, rating: 5)).not_to be_valid
    end

    it "is not valid when rating is not numerical" do
      expect(Comment.new(body: "Amazing bicycle", user: @user, product: @product, rating: "Alexandre")).not_to be_valid
    end

    it "is valid when creating a normal comment" do
      expect(Comment.new(body: "Amazing bicycle", user: @user, product: @product, rating: 5)).to be_valid
    end
  end
end
