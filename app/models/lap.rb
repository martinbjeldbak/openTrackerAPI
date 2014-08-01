class Lap < ActiveRecord::Base
  # lap_nr, session
  belongs_to :race_session
  has_many :positions
end
