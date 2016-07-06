FactoryGirl.define do
  sequence(:name) { |n| "Product ##{n}" }

  factory :product do
    name
  end

  factory :product_with_price, class: Product do
    name
    price 49.99
  end
end
