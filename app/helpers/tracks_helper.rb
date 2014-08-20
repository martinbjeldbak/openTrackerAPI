module TracksHelper
  def track_img_path(track)
    "tracks/#{track.img_name}.png"
  end
end
