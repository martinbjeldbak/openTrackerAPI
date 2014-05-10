class Key < ActiveRecord::Base
  # string key

  belongs_to :keyable, polymorphic:  true

  before_create :generate_key

  def generate_key
    begin
      self.key = SecureRandom.hex
    end while self.class.exists?(key: key)
  end
end
