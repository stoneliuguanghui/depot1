module MerchantsHelper
	def sign_in(merchant)
		remember_token = Merchant.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		merchant.update_attribute(:remember_token,Merchant.encrypt(remember_token))
		self.current_merchant=merchant
	end

	def current_merchant=merchant
		@current_merchant=merchant
	end

	def current_merchant
		remember_token = Merchant.encrypt(cookies[:remember_token])
		@current_merchant ||= Merchant.find_by(remember_token: remember_token)
	end

	def sign_out
		self.current_merchant =nil
		cookies.delete(:remember_token)
	end
end
