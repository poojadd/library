class CreateMybooks < ActiveRecord::Migration
  def change
    create_table :mybooks do |t|
      t.string :title
      t.float :price
      t.integer :mysubject_id
      t.text :description

      t.timestamps
    end
  end
end
