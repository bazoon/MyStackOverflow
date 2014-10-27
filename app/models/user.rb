class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :authorizations
  validates :email, :name, presence: true

  before_create { skip_confirmation! }

  VOTE_DOWN_PRICE = 1 #TODO 

  include Voteable  


  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    password = Devise.friendly_token[0, 20]
    

    if user
      user.create_authorization(auth)
    elsif email
      user = User.create!(email: email, name: 'foo', password: password, password_confirmation: password)
      user.create_authorization(auth)
    else
      user = User.new(password: password, password_confirmation: password)
    end

    user
    
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end


  def send_confirmation_instructions(provider)
    generate_confirmation_token! if confirmation_token.nil?
    devise_mailer.send(:confirmation_instructions, self, confirmation_token, provider: provider).deliver
  end

  
end
