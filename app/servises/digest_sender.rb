class DigestSender
  
  def self.send
    User.find_each do |user|
      DigestWorker.perform_async(user.id)
    end
  end
  
end