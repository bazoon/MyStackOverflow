class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
  #TODO: test here
  
  def self.find_vote(object, user)
    find_or_initialize_by(voteable: object, user: user)
  end

  def self.voted?(object, user)
    !where(voteable: object, user: user).first.nil? #TODO: exist?
  end

  def self.up(object, user)
    vote = find_vote(object, user)
    vote.update(vote: 1)
  end

  def self.down(object, user)
    vote = find_vote(object, user)
    vote.update(vote: -1)
  end

end
