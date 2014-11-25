# include Rails.application.routes.url_helpers


class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :body, :commentable_type, :edit_path, :destroy_path, :created_at, :updated_at, :commentable, :user_id, :user_name
  # has_one :commentable, polymorphic: true

  def user_name
    object.user.name
  end

  def commentable
    object.commentable
  end

  def commentable_type
    
    object.commentable_type
  end

  def edit_path
    edit_comment_path(object)
  end

  def destroy_path
    comment_path(object)
  end

end
