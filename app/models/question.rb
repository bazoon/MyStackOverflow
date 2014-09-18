class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :answers
  belongs_to :user

  def user_email
    user && user.email
  end
  
end
