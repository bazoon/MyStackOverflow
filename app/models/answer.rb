class Answer < ActiveRecord::Base
  belongs_to :qustion
  belongs_to :user
end
