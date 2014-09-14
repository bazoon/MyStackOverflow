class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  
  has_many :answers 
  belongs_to :user
  
end
