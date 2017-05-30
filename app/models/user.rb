class User < ApplicationRecord
  extend FriendlyId

  TEMP_EMAIL_PREFIX = 'temp@temp'
  TEMP_EMAIL_REGEX = /\Atemp@temp/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :confirmation_token
  after_create :create_friends_list
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :recipes
  has_many :comments, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :votes, foreign_key: :user_id
  has_many :authorizations, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one :friends_list, dependent: :destroy


  def author_of?(obj)
    id == obj.user_id
  end

  def send_confirmation(params)
    self.generate_confirmation_token!
    self.update(params)
    Devise::Mailer.confirmation_instructions(self, self.confirmation_token).deliver_now
  end

  def create_authorization(auth) 
    authorizations.create(provider: auth.provider, uid: auth.uid) 
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email] if auth.info && auth.info[:email] 
    email ||= "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"

    user = User.where(email: email).first

    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[1, 20]
      user = User.new(email: email , password: password, password_confirmation: password, account_confirmed: (email != "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com") ? true : false)
      user.skip_confirmation!
      user.save!
      user.create_authorization(auth)
    end
    
    user
  end

  def create_friends_list
    self.build_friends_list
  end
end
