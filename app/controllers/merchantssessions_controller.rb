class MerchantssessionsController < ApplicationController
  def new
  end

  def create
  	merchant = Merchant.find_by(merchant_email: params[:session][:merchant_email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		sign_in merchant
  	else
  		render 'new'
  	end
  end

  def destroy
  	sign_out
  	redirect_to signup_path
  end
end
