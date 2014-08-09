class RaceSessionSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :ended_at, :ot_version, :ac_version, :driver, :track,
             :track_img_path, :track_config, :car

  has_one :key

  def key
    object.key.key
  end

  def track_img_path
    ActionController::Base.helpers.image_path("tracks/#{object.track}.png")
  end
end
