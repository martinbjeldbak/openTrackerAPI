class AllowDuplicateEmailOnUsers < ActiveRecord::Migration
  def change
    remove_index :users, :email
    add_index :users, :uid, unique: true
  end
end
