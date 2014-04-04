class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.string :version
      t.belongs_to :user

      t.timestamps
    end
  end
end
