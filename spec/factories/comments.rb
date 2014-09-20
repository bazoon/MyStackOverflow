# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'MyComment'
    association :commentable, factory: :answer
    commentable_type 'Answer'
    
  end



  factory :question_comment, class: Comment do
    body 'MyComment'
    association :commentable, factory: :question
    commentable_type 'Question'
  end


end
