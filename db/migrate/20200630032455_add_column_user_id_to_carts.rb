class AddColumnUserIdToCarts < ActiveRecord::Migration[5.2]
  def change
  	add_column :carts,:user_id,:bigint
  	add_index :carts,:user_id
  end
end
