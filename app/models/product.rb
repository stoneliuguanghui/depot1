class Product < ApplicationRecord
	validates :title,:description,:image_url,:presence=>true
	has_many :line_items
	has_many :orders,:through=>:line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	private
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base,'Line Item present')
				return false
			end
			
		end
end
