class RenameSessionToRaceSession < ActiveRecord::Migration
  def change
    rename_table :sessions, :race_sessions
  end
end
