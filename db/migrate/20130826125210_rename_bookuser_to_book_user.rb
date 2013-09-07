class RenameBookuserToBookUser < ActiveRecord::Migration
  def up
    rename_table :bookusers, :book_users
  end

  def down
    rename_table :book_users, :bookusers
  end
end
