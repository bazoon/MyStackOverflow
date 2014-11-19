class DigestWorker
  
  include Sidekiq::Worker
  
  
  #Параметры не могут быть сложными объектами
  def perform(user_id)
    user = User.find(user_id)
    DigestMailer.every_day_questions(user, Question.last_24_hours).deliver
  end
  
end