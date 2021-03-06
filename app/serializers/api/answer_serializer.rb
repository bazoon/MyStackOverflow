class Api::AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  
  has_many :attachments
  has_many :comments, serializer: Api::CommentSerializer
end
