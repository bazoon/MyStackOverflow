class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  has_many :votes, as: :voteable, dependent: :destroy

  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :selected_answers, -> { where(selected: true) }
  
  is_impressionable counter_cache: true, unique: :request_hash
  

  include Taggable
  include Voteable

  VOTE_DOWN_WEIGHT = 2
  VOTE_WEIGHT = 2

  def vote_weight
    VOTE_WEIGHT
  end

  def vote_down_weight
    VOTE_DOWN_WEIGHT
  end

  def user_email
    user.email if user
  end

  def class_underscore
    self.class.to_s.underscore
  end

  def deselect_all_answers
    answers.deselect
  end
  
end
