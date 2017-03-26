class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  
  validates :title, :description, presence: { message: 'не может быть пустым' }

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

end
