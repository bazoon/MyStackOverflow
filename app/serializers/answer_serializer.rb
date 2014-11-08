class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :edit_path, :destroy_path, :select_path, :rating, :created_at, :user_email, :updated_at
  has_many :tags
  has_many :votes
  has_many :attachments
  
  has_many :comments



  def user_email
    object.user.email if object.user
  end

  # def created_at
  #   I18n.l(object.created_at) if object.created_at
  # end


  def edit_path
    "/answers/#{object.id}/edit"
  end

  def destroy_path
    "/answers/#{object.id}"
  end

  def select_path
    "/answers/#{object.id}/select"
  end  

end
