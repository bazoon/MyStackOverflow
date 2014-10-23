# Module for voting
module Voteable
 # Синхронно изменяет рейтинги моделей


  
  module InstanceMethods
    
    
    def vote_up(user)
      self.user.up_by(vote_weight)
      up_by(1)
    end

    def vote_down(user)
      self.user.down_by(vote_down_weight)
      down_by(1)
    end


    def up_by(n)
      update(rating: rating + n)
    end

    def down_by(n)
      update(rating: rating - n)
    end
 
  end
  
  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end
