class Cart < ApplicationRecord
	has_many :line_items,:dependent=>:destroy
	def total_price
		line_items.to_a.sum{|item| item.total_price}
		
	end
	
	def add_product(product_id)
		current_item=line_items.find_by_product_id(product_id)

		if current_item
			current_item.quantity+=1

		else
			
			current_item=line_items.build(:product_id=>product_id)
			
		end
		current_item
	end

	def total_items
		line_items.sum(:quantity)
	end

	def up_combine_all_cart
		Cart.all.each do |cart|
			sums=cart.line_items.group(:product_id).sum(:quantity)
			sums.each do |product_id,quantity|
				if quantity>1
					cart.line_items.where(:product_id=>product_id,:quantity=>quantity).delete_all
					cart.line_items.create(:product_id=>product_id,:quantity=>quantity)
				end
			end
		end	
	end

	def down_combine_all_line_item
		LineItem.where("quantity>1").each do |line_item|
			line_item.quantity.times do
				LineItem.create :cart_id=>line_item.cart_id,:product_id=>line_item.product_id,
				:quantity=>1
			end
			line_item.destroy
		end	
	end

end
