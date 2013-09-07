class CreateBookUsers < ActiveRecord::Migration
  def change
    create_table :book_users do |t|
      t.integer  :user_id
      t.integer  :mybook_id
      t.datetime :issuedate
      t.datetime :returndate
      t.boolean :returned

      t.timestamps
    end
  end
end
