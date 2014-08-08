class CreateRaceSessions < ActiveRecord::Migration
  def change
    create_table :race_sessions do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.string :ac_version, null: false
      t.string :ot_version, null: false
      t.string :user_agent, null: false
      t.string :car, null: false
      t.string :driver, null: false
      t.string :track, null: false
      t.string :track_config, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end