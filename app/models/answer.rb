class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, :user_id, :question_id, presence: true
  has_many :comments, as: :commentable
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :votes, as: :voteable

  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  VOTE_WEIGHT = 10
  VOTE_DOWN_WEIGHT = 2
  ACCEPT_WEIGHT = 15
  include Voteable

  def set_as_selected
    selected_answers.update_all(selected: false)
    update(selected: !selected)
  end
  
  
  #вынести в question
  def selected_answers
    question.answers.where(selected: true)
  end

  def class_underscore
    self.class.to_s.underscore
  end

end
