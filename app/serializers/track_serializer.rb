class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :configuration, :img_path, :img_name, :img_height, :img_width, :img_scale,
             :x_offset, :z_offset, :scale_factor

  has_many :race_sessions, embed: :ids
end