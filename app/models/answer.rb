class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, :user_id, :question_id, presence: true
  has_many :comments, as: :commentable


  def set_as_selected
    selected_answers.update_all(selected: false)
    update(selected:  !selected)
  end
  
  

  def selected_answers
    question.answers.where(selected: true)
  end


end
