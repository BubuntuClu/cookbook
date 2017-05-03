class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  
  validates :body, presence: { message: 'не может быть пустым' }

  scope :only_admin, ->{ where(by_admin: true) }
  scope :only_user, ->{ where(by_admin: false) }

  def author_name
    self.user.email
  end
end
