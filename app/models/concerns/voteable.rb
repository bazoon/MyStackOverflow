# Module for voting
module Voteable
  
  # methods included as intance
  module InstanceMethods
    
    
    def vote_up(user)
      Vote.up(self, user)
      up_by(1)
    end

    def vote_down(user)
      Vote.up(self, user)
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
