class RaceSession < ActiveRecord::Base
  validates :ot_version, :ac_version, :user_id, presence: true

  validates :ac_version, inclusion: { in: %w(1.0),
                                   message: "%{value} is not a valid AC version"}

  validates :ot_version, inclusion: { in: %w(0.1),
                                   message: "%{value} is not a valid OpenTracker version"}

  belongs_to :user
  belongs_to :track
  has_many :laps, dependent: :destroy
  has_many :positions, through: :laps
  has_one :key, as: :keyable
  accepts_nested_attributes_for :key

  def self.live
    RaceSession.all.select{|sess| !sess.has_ended?}
  end

  after_create :add_key

  def fastest_lap
    fastest = laps.first
    self.laps.each do |lap|
      fastest = lap if lap.best_lap > fastest.best_lap
    end
    fastest
  end

  def add_key
    self.key = Key.new
  end

  def lap_count
    self.laps.count
  end

  def is_live?
    !has_ended?
  end

  def has_ended?
    if ended_at
      true
    elsif self.laps.count > 0 && self.laps.last.positions.count > 0 && (Time.now - self.laps.last.positions.last.created_at) > 15.minutes
      # Since 15 mins have gone since last position for this session, update ended_at
      self.ended_at = self.laps.last.positions.last.created_at
      self.save!
      true
    elsif self.laps.empty? || (self.laps && self.laps.last.positions.empty?)
      true
    else
      false
    end
  end
end