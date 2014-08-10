class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false, unique: true
      t.string :configuration
      t.string :img_name, null: false
      t.float :img_height, null: false # from AC .ini
      t.float :img_width, null: false # from AC .ini
      t.float :img_scale, null: false, default: 1
      t.float :x_offset, null: false # from AC .ini
      t.float :z_offset, null: false # from AC .ini
      t.float :scale_factor, null: false, default: 1 # from AC .ini

      t.timestamps
    end

    remove_column :race_sessions, :track, :string
    remove_column :race_sessions, :track_config, :string
    add_column :race_sessions, :track_id, :integer, references: :tracks
  end
end
