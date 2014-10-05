class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :comments, as: :commentable
  has_many :answers
  belongs_to :user

  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def user_email
    user.email if user
  end

  def class_underscore
    self.class.to_s.underscore
  end
  
end
