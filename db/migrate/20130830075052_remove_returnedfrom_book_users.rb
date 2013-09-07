class RemoveReturnedfromBookUsers < ActiveRecord::Migration
  def up
    remove_column :book_users, :returned , :boolean
  end

  def down
    add_column :book_users, :returned, :boolean
  end
end

class RemoveRolefromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :role, :string
  end

  def down
    add_column :users, :role, :string
  end
end