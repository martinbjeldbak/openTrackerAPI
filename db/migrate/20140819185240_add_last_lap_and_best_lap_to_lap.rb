class AddLastLapAndBestLapToLap < ActiveRecord::Migration
  def change
    add_column :laps, :last_lap, :integer, default: -1
    add_column :laps, :best_lap, :integer, default: -1
  end
end
