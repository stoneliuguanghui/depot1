class StoreController < ApplicationController
	skip_before_action :authorize
  def index
  	
  	@products=Product.all
  	@cart=current_cart
  end
end
