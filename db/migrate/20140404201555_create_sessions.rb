class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.string :version, null: false
      t.belongs_to :user, null: false
      t.string :key, null: false

      t.timestamps
    end
  end
end