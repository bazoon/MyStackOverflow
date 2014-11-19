class UserDigestWorker
  include Sidekiq::Worker

  def perform(email)

    #TODO: bug? does not find user by id
    
    DigestMailer.every_day_questions(email, Question.last_24_hours).deliver
  end


end