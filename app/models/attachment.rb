class Attachment < ApplicationRecord
  belongs_to :recipe

  mount_uploader :file, FileUploader

  validates :file, :type, presence: true
end
