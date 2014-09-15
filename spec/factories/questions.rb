# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :question do
    title "title"
    body "body"
    association :user

  end

  factory :user_question, class: Question do
    title "user title"
    body "body"
    association :user
  end



  factory :invalid_question, class: Question do
    title nil
    body nil
  end

end
