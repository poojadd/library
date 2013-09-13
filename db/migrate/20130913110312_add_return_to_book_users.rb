class AddReturnToBookUsers < ActiveRecord::Migration
  def up
    add_column :book_users, :returned, :boolean
  end

  def down
    remove_column :book_users, :returned , :boolean
  end
end
