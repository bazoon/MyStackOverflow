class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :authorizations
  validates :email, :name, presence: true

  VOTE_DOWN_PRICE = 1 #TODO 

  include Voteable  


  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, name: 'face', password: password, password_confirmation: password)
    end

    user.create_authorization(auth)

    user
    
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
  
end
