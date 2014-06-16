class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.float :x, null: false
      t.float :y, null: false
      t.float :z, null: false
      t.belongs_to :lap, null: false

      t.timestamps
    end
  end
end
