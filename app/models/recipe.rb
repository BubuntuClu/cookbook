class Recipe < ApplicationRecord
  include Bootsy::Container

  has_many :ingredients, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  
  validates :title, :description, presence: { message: 'не может быть пустым' }

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  enum status: [:draft, :moderation, :published]

  scope :only_published, ->{ where(status: :published) }
  scope :only_moderation, ->{ where(status: :moderation) }

  def is_draft?
    draft?
  end

  def is_moderation?
    moderation?
  end

  def is_published?
    published?
  end
end
