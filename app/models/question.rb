class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user, counter_cache: true
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  has_many :votes, as: :voteable, dependent: :destroy

  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :question_subscriptions, dependent: :destroy
  
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :selected_answers, -> { where(selected: true) }
  scope :last_24_hours, -> { where('created_at > ?', 24.hours.ago) }

  scope :interesting, -> { order('impressions_count desc') }
  scope :featured, -> { order('rating desc') }
  scope :hot, -> { order('answers_count desc') }
  scope :week, -> { where('created_at > ?', 7.days.ago) }
  scope :month, -> { where('created_at > ?', 1.month.ago) }

  
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

  def show_title
    "Question: #{title}"
  end

  def show_object
    self
  end

  def notify_subscribers

    question_subscriptions.each do |qs|
      QuestionSubscriptionWorker.perform_async(qs.user_id, qs.question.id)
    end
  end

  def notify_author(new_answer)
    QuestionAuthorWorker.perform_async(user.id, new_answer.id)
  end

end
