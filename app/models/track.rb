class Track < ActiveRecord::Base
  has_many :race_sessions

  def img_path
    ActionController::Base.helpers.image_path("tracks/#{self.img_name}.png")
  end
end
