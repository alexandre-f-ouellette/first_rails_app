require 'rails_helper'

describe Product do
  context "when the product has comments" do
    before do
      @product = FactoryGirl.create(:product)
      @user = FactoryGirl.build(:user)

      @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
      @product.comments.create!(rating: 3, user: @user, body: "OK bike.")
      @product.comments.create!(rating: 5, user: @user, body: "Great bike!")
    end

    it "returns the average rating of comments" do
      expect(@product.average_rating).to eq(3)
    end

    it "is not valid when name is not present" do
      expect(Product.new(description: "A great bike")).not_to be_valid
    end
  end

  context "has a price" do
    before do
      @product_with_price = FactoryGirl.create(:product_with_price)
    end

    it "returns the price in cents by multiplying by 100" do
      expect(@product_with_price.price_in_cents).to eq @product_with_price.price*100
      expect(@product_with_price.price_in_cents).to be_an(Integer)
    end
  end
end
