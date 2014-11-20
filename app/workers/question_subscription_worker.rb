class QuestionSubscriptionWorker
  
  include Sidekiq::Worker
  

  def perform(user_id, question_id)
    QuestionSubscriptionMailer.notify(User.find(user_id), Question.find(question_id)).deliver
  end
  
end