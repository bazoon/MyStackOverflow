class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :title, :updated_at, :created_at


  has_many :tags
  has_many :votes
  has_many :attachments
  has_many :answers
  has_many :comments


end
