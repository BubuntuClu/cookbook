class Discussion < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  
  validates :body, presence: { message: 'не может быть пустым' }

  def author_name
    self.user.email
  end
end
