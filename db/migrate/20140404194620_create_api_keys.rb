class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token, unique: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
