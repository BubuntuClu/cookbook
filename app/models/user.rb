class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :comments, dependent: :destroy
  has_many :votes, foreign_key: :user_id

  def author_of?(obj)
    id == obj.user_id
  end
end
