class Api::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :title, :updated_at, :created_at


  has_many :attachments
  has_many :comments, serializer: Api::CommentSerializer


end
