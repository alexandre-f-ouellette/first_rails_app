FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@example.org" }
  sequence(:last_name) { |n| "User ##{n}" }

  factory :user do
    email
    password '1234567890'
    first_name 'Test'
    last_name
    admin false
  end

  factory :admin_user, class: User do
    email
    password '1234567890'
    first_name 'Admin'
    last_name
    admin true
  end

  sequence(:name) { |n| "Product ##{n}" }

  factory :product do
    name
  end

  factory :comment do
    body 'This is awesome'
    rating 5
    product
    user
  end
end
