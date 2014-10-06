class Tagging < ActiveRecord::Base
  # validates :tag_id, :taggable_id, :taggable_type, presence: true
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
