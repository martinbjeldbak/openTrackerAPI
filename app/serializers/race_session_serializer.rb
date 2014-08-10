class RaceSessionSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :ended_at, :ot_version, :ac_version, :driver, :track, :car

  has_one :key
  has_one :track

  def key
    object.key.key
  end
end
