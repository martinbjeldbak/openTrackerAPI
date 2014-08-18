class Event < ActiveRecord::Base
  has_many :race_sessions, dependent: :destroy
  has_many :users, through: :race_sessions
end
