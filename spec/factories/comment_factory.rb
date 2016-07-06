FactoryGirl.define do
  factory :comment do
    body 'This is awesome'
    rating 5
    product
    user
  end
end
