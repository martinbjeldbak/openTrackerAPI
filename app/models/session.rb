class Session < ActiveRecord::Base
  # started_at, ended_at, version, user, key

  belongs_to :user
  has_one :key, as: :keyable
end