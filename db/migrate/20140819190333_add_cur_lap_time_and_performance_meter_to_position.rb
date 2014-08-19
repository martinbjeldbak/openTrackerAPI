class AddCurLapTimeAndPerformanceMeterToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :lap_time, :integer, default: -1
    add_column :positions, :performance_meter, :float, default: 0.0
  end
end
