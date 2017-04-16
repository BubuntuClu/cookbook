class Comment < ApplicationRecord
  belongs_to :recipe
  
  validates :body, presence: { message: 'не может быть пустым' }

  scope :only_admin, ->{ where(by_admin: true) }
  scope :only_user, ->{ where(by_admin: false) }

  def author_name
    User.find(self.user_id).email
  end
end
