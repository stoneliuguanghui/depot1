class CreateMerchantItems < ActiveRecord::Migration[5.2]
  def change
    create_table :merchant_items do |t|
      t.integer :merchant_id
      t.integer :product_id

      t.timestamps
    end
  end
end
