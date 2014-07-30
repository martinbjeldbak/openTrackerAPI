class SessionSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :ended_at, :ot_version, :ac_version

  def key
    object.key.key
  end
end
