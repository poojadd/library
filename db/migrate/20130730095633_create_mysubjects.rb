class CreateMysubjects < ActiveRecord::Migration
  def change
    create_table :mysubjects do |t|
      t.string :name
      t.timestamps
    end


  end

end
