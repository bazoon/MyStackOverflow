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

  before_create { skip_confirmation!  }

  scope :excluding, -> (idd) { where.not(id: idd) }

  VOTE_DOWN_PRICE = 1 #TODO 

  include Voteable  
  mount_uploader :avatar, AvatarUploader


  def self.find_for_oauth(auth)
    authorization = Authorization.find_by_auth(auth)
    return authorization.user if authorization
 
    email, name = auth.info[:email], auth.info.nickname || auth.info.name if auth.info
    user = User.where(email: email).first
    
    if user
      user.create_authorization(auth)
    else
      email ? create_user_from_oauth(auth, name) : User.new(name: name)
    end
    
  end



  def send_confirmation_instructions(provider)
    generate_confirmation_token! if confirmation_token.nil?
    devise_mailer.send(:confirmation_instructions, self, confirmation_token, provider: provider).deliver
  end


  def confirm_and_authorize(provider, uid) #TODO: похожий внизу?
    confirm!
    authorizations.create(provider: provider, uid: uid)
  end

  
  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
    self
  end


  private

  def self.create_user_from_oauth(auth, name)
    password = Devise.friendly_token[0, 20]
    user = User.create!(email: auth.info[:email], name: name, password: password, password_confirmation: password)
    user.create_authorization(auth)
    user
  end

  
  
end
