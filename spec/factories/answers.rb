# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :answer do
    body "MyText"
    association :question
    association :user
  end

  factory :invalid_answer, class: Answer do
    question_id nil
    body nil
    user_id nil
  end

  

end
