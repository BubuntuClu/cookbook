class Message < ApplicationRecord
  belongs_to :user
  
  validates :body, presence: { message: 'не может быть пустым' }
end
