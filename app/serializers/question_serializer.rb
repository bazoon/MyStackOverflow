class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :title


  has_many :tags
  has_many :votes
  has_many :attachments


end
