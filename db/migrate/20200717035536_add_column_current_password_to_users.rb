class AddColumnCurrentPasswordToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users,:current_password,:string
  	add_index :users,:current_password
  end
end
