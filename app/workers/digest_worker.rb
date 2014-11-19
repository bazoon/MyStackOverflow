class DigestWorker
  
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # recurrence { hourly.minute_of_hour(56,57,58) }
  recurrence { daily }
  

  # it passes params here, though they are not used
  def perform(*args)
    User.find_each do |user|
      UserDigestWorker.perform_async(user.email)
    end
    
  end
  
end