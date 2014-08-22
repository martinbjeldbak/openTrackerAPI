class UserNameCannotBeNil < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, null: false
  end
end
