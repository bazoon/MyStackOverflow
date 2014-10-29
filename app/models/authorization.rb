class Authorization < ActiveRecord::Base
  validates :provider, :uid, presence: true
  belongs_to :user


  def self.find_by_auth(auth)
    where(provider: auth.provider, uid: auth.uid.to_s).first
  end

end
