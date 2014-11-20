class QuestionSubscription < ActiveRecord::Base
  belongs_to :question
  belongs_to :user


  def self.toggle_subscription(question, user)
    subscription = QuestionSubscription.where(question: question, user: user).first
    
    if subscription
      subscription.destroy      
    else
      create(question: question, user: user) 
    end    
  end  

  
end
