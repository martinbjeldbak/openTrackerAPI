class Lap < ActiveRecord::Base
  # lap_nr, session
  belongs_to :race_session
  has_many :positions, dependent: :destroy

  def number
    self.race_session.laps.index(self)
  end
end
