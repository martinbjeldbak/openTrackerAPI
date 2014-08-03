class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.timestamps
    end

    add_column :race_sessions, :event_id, :integer
  end
end
