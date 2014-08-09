class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.float :x, null: false
      t.float :y, null: false
      t.float :z, null: false
      t.float :rpm, null: false
      t.float :speed, null: false # speed in m/s
      t.float :steer_rot, null: false # steering rotation in radians
      t.integer :gear, null: false
      t.float :on_gas, null: false
      t.float :on_brake, null: false
      t.boolean :on_clutch, null: false

      t.belongs_to :lap, null: false

      t.timestamps
    end
  end
end
