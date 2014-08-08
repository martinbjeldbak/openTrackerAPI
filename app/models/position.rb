class Position < ActiveRecord::Base
  validates :steer_rot, numericality: { greater_than_or_equal_to: -451,
                                        less_than_or_equal_to: 451}
  validate :check_delta

  belongs_to :lap

  def previous_position
    latest_pos = self.lap.positions.last

    if self == latest_pos
      nil
    else
      self.lap.positions[-1]
    end
  end

  def km_h
    self.speed * 3.6
  end

  private

  def check_delta
    # If update time has
    #errors.add(:created_at, 'Updating too fast') if previous_position && (Time.now - previous_position.created_at) < 1.seconds
  end
end
