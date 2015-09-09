class AddIndexToUesrsEmail < ActiveRecord::Migration
  # add_index :table, :column [, options]
  def change
  	add_index :users, :email, unique: true
  end
end
