class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :merchant_name
      t.string :merchant_email
      t.string :password_digest
      t.string :merchant_address
      t.string :remember_token
      t.decimal :longitude, :precision=>10, :scale=>6
      t.decimal :latitude, :precision=>11,:scale=>7

      t.timestamps
    end
  end
end
