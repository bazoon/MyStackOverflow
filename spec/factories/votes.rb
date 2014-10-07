# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    votable_id 1
    votable_type "MyString"
    vote 1
    user_id 1
  end
end
