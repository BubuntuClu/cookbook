class Recipe < ApplicationRecord
  include Bootsy::Container
  include Votable

  has_many :ingredients, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  
  validates :title, presence: { message: 'не может быть пустым' }

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  enum status: [:draft, :moderation, :published]

  scope :only_published, ->{ where(status: :published) }
  scope :only_moderation, ->{ where(status: :moderation) }

  mount_uploader :preview_image, FileUploader

  def set_to_draft(comment)
    self.comments.create(body: comment[:body], by_admin: true)
    self.update_attributes(status: :draft) 
  end

  def set_to_publish(*args)
    self.comments.where(by_admin: true).destroy_all
    self.update_attributes(status: :published) 
  end

  def set_to_moderation(*args)
    self.update_attributes(status: :moderation) 
  end
end
