# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyText"
    association :commentable, factory: :answer
    commentable_type "Answer"
    
  end
end
