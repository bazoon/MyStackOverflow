# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reputation do
    reputationable_id 1
    reputationable_type "MyString"
    reputation 1
  end
end
