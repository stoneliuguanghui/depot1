class MerchantsController < ApplicationController

	def new
		@merchant=Merchant.new
	end

	def create
		@merchant=Merchant.new(merchant_params)
		
		if @merchant.save
			sign_in @merchant
			redirect_to signin_path
		else
			render 'new'
		end
	end

	def form
		
	end

	private
	def merchant_params
		params.require(:merchant).permit(:merchant_name,:merchant_email,:password,:password_confirmation)	
	end
end
