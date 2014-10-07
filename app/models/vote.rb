class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user


  def self.voted?(object, user)
    !where(voteable_type: object.class.to_s, voteable_id: object.id, user_id: user).first.nil?
  end

end
