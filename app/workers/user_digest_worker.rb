class UserDigestWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    DigestMailer.every_day_questions(user, Question.last_24_hours).deliver
  end


end