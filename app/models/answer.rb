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

  VOTE_WEIGHT = 10 #константы куда-то
  VOTE_DOWN_WEIGHT = 2
  ACCEPT_WEIGHT = 15

  include Voteable

  def set_as_selected
    question.deselect_all_answers
    update(selected: !selected)
  end
  
  def class_underscore
    self.class.to_s.underscore
  end

  def self.deselect
    update_all(selected: false)
  end
end
