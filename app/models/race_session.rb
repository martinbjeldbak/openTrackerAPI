class RaceSession < ActiveRecord::Base
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

  def has_ended?
    if ended_at != nil
      true
    elsif self.laps.last.positions.count > 0 && (Time.now - self.laps.last.positions.last.created_at) > 15.minutes
      # Since 15 mins have gone since last position for this session, update ended_at
      self.ended_at = self.laps.last.positions.last.created_at
      self.save!
      true
    else
      false
    end
  end
end