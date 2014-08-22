class UserNameCannotBeNil < ActiveRecord::Migration
  def self.up
    change_column :users, :name, :string, null: false
  end

  def self.down
    change_column :users, :name, :string, null: true
  end
end
