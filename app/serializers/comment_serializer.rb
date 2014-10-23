# include Rails.application.routes.url_helpers


class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :body, :commentable_type, :edit_path, :destroy_path
  has_one :commentable, polymorphic: true

  def commentable_type
    object.commentable.class.to_s
  end

  def edit_path
    edit_comment_path(object)
  end

  def destroy_path
    comment_path(object)
  end

end
