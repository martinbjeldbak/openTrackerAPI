class Position < ActiveRecord::Base
  validates :steer_rot, numericality: { greater_than_or_equal_to: -451,
                                        less_than_or_equal_to: 451}
  validates :on_brake, numericality: { greater_than_or_equal_to: 0.0,
                                       less_than_or_equal_to: 1.0}
  validates :on_gas, numericality: { greater_than_or_equal_to: 0.0,
                                       less_than_or_equal_to: 1.0}
  validate :check_delta

  belongs_to :lap

  def previous_position
    latest_pos = self.lap.positions.last

    if self == latest_pos
      self
    else
      self.lap.positions[-2]
    end
  end

  def km_h
    self.speed * 3.6
  end

  def self.latest_position
    self.lap.positions.last
  end

  private

  def check_delta
    #errors.add(:created_at, 'Updating too fast') if previous_position && (Time.now - previous_position.created_at) < 0.5.second
  end
end
