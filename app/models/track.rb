class Track < ActiveRecord::Base
  has_many :race_sessions
end
