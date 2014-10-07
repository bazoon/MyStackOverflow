# Module for voting
module Voteable
  
  # methods included as intance
  module InstanceMethods
    
    def find_vote(user)
      votes.find_or_initialize_by(voteable_type: self.class.to_s,
                                  voteable_id: id, user_id: user.id)
    end
 
    def vote_up(user)
      vote = find_vote(user)
      vote.update(vote: 1)
    end

    def vote_down(user)
      vote = find_vote(user)
      vote.update(vote: -1)
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
