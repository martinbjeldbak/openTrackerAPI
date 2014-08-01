class RaceSessionSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :ended_at, :ot_version, :ac_version

  has_one :key

  def key
    object.key.key
  end
end
