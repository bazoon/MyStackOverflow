class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user
  validates :body, :user_id, :question_id, presence: true
  has_many :comments, as: :commentable
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :votes, as: :voteable

  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  before_create :update_rating

  VOTE_WEIGHT = 1 #константы куда-то
  VOTE_DOWN_WEIGHT = 1
  ACCEPT_WEIGHT = 3
  FIRST_WEIGHT = 1
  OWN_FIRST_WEIGHT = 3
  OWN_WEIGHT = 2


  include Voteable


  def vote_weight
    VOTE_WEIGHT
  end

  def vote_down_weight
    VOTE_DOWN_WEIGHT
  end

  def set_as_selected
    unless selected
      question.deselect_all_answers
      update(selected: true)
    end
  end
  
  def class_underscore
    self.class.to_s.underscore
  end

  def self.deselect
    update_all(selected: false)
  end

  def show_title
    "Answer: #{body}"
  end

  def show_object
    self.question
  end

  private

  def update_rating
    
    if question.user == user
      if question.answers.empty?
        user.up_by(OWN_FIRST_WEIGHT) 
      else
        user.up_by(OWN_WEIGHT) 
      end
    else
      user.up_by(FIRST_WEIGHT) if question.answers.empty?
    end
  end

end
