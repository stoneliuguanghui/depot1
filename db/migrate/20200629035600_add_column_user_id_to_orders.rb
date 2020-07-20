class AddColumnUserIdToOrders < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :user_id, :bigint
    add_index :orders, :user_id
  end

  def down
  	remove_column :orders, :user_id, :bigint
  end
end
