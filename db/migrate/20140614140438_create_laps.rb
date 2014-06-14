class CreateLaps < ActiveRecord::Migration
  def change
    create_table :laps do |t|
      t.integer :lap_nr, null: false
      t.belongs_to :session, null: false

      t.timestamps
    end
  end
end