class Session < ActiveRecord::Base
  # started_at, ended_at, version, user, key

  belongs_to :user

  before_create :generate_key

  def generate_key
    begin
      self.key = SecureRandom.hex
    end while self.class.exists?(key: key)
  end
end