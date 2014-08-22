class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:steam]

  has_many :race_sessions, dependent: :destroy

  before_save :ensure_authenticaton_token

  validates :name, length: { minimum: 1 }

  def email_required?
    provider.blank?
  end

  def is_racing?
    race_sessions.select(&:is_live?).any?
  end

  def self.find_or_create_for_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  def self.search(search)
    if search
      where('email = ? OR name = ? OR uid = ?', search, search, search)
    else
      all
    end
  end

  def ensure_authenticaton_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end