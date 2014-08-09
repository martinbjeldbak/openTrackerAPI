class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :configuration
      t.string :img_name
      t.float :img_height
      t.float :img_width
      t.float :x_offset
      t.float :z_offset

      t.timestamps
    end

    #remove_column :race_sessions, :track, :string
    #remove_column :race_sessions, :track_config, :string
    #add_column :race_sessions, :track, :integer
  end
end
