class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  delegate :identifier, to: :file

  belongs_to :attachmentable, polymorphic: true
end
