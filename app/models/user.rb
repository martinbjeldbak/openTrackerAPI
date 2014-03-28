class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:steam]

  def email_required?
    provider.blank?
  end

  def self.find_for_steam_oauth(auth)
    logger.debug("ALL: " + auth.info.inspect.to_s)
    logger.debug("INFO: " + auth.info.inspect.to_s)

    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end
end