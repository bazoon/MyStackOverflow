# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "user_#{n}" }

  factory :user do
    email
    name  
    password "12345678"
  end
end
