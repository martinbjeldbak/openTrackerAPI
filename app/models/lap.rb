class Lap < ActiveRecord::Base
  # lap_nr, session
  belongs_to :session
  has_many :positions
end
