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
end
