class RenameBookUserToBookuser < ActiveRecord::Migration
  def up
    rename_table :book_users, :bookusers
  end

  def down
    rename_table :bookusers, :book_users
  end
end
