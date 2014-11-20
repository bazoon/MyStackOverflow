class QuestionAuthorWorker
  include Sidekiq::Worker


  def perform(user_id, answer_id)
    
    QuestionAuthorMailer.notify(User.find(user_id), Answer.find(answer_id)).deliver


  end
  
end