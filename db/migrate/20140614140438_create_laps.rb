class CreateLaps < ActiveRecord::Migration
  def change
    create_table :laps do |t|
      t.integer :lap_nr
      t.belongs_to :session

      t.timestamps
    end
  end
end
