class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :key, null: false, unique: true
      t.references :keyable, polymorphic: true

      t.timestamps
    end
  end
end