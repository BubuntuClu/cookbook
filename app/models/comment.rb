class Comment < ApplicationRecord
  belongs_to :recipe
  
  validates :body, presence: { message: 'не может быть пустым' }
end
