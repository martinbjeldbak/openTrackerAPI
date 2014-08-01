class Position < ActiveRecord::Base
  validates :steer_rot, numericality: { greater_than_or_equal_to: -6.28318531,
                                        less_than_or_equal_to: 6.28318531}
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

  private

  def check_delta
    if previous_position && (Time.now - previous_position.created_at) < 2.seconds
      errors.add(:created_at, 'Updating too fast')
    end
  end
end
