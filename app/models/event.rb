class Event < ActiveRecord::Base
  has_many :race_sessions
  has_many :users, through: :race_sessions
end
