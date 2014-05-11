class Session < ActiveRecord::Base
  # started_at, ended_at, version, user, key

  belongs_to :user
  has_one :key, as: :keyable
  accepts_nested_attributes_for :key

  after_create :add_key

  def add_key
    self.key = Key.new
  end
end