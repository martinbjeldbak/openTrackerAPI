class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :x, null: false
      t.integer :y, null: false
      t.integer :z, null: false
      t.belongs_to :lap, null: false

      t.timestamps
    end
  end
end
