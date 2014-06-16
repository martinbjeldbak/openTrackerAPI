class Position < ActiveRecord::Base
  validates :steer_rot, numericality: { greater_than_or_equal_to: -6.28318531,
                                        less_than_or_equal_to: 6.28318531}

  belongs_to :lap
end
