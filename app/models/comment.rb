class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user, counter_cache: true
  validates :body, presence: true

  def show_title
    "Comment: #{body}"
  end

  def show_object
    commentable.show_object
  end

end
