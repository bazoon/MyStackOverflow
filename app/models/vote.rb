class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user


  def self.voted?(object, user)
    !where(voteable: object, user: user).first.nil?
  end

end
