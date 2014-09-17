class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, :user_id, :question_id, presence: true


  def set_as_selected

    other = question.answers.where(selected: true).first
    
    if other
      other.selected = false
      other.save
    end

    self.selected = true
    save
    

  end
  



end
