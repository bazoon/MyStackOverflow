class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  delegate :identifier, to: :file

  belongs_to :attachmentable, polymorphic: true

  def file_name
    File.basename(file.file.file)
  end

end
