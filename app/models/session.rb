class Session < ActiveRecord::Base
  # started_at, ended_at, version, user, key

  validates :ot_version, :ac_version, :user_id, presence: true

  validates :ac_version, inclusion: { in: %w(1.0),
                                   message: "%{value} is not a valid AC version"}

  validates :ot_version, inclusion: { in: %w(0.1),
                                   message: "%{value} is not a valid OpenTracker version"}

  belongs_to :user
  has_many :laps
  has_one :key, as: :keyable
  accepts_nested_attributes_for :key

  after_create :add_key

  def add_key
    self.key = Key.new
  end
end