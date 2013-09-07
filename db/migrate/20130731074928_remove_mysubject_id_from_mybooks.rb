class RemoveMysubjectIdFromMybooks < ActiveRecord::Migration
  def up
    add_column :mybooks, :mysubject_id, :integer
  end

  def down
    remove_column  :mybooks, :mysubject_id, :integer
  end
end
