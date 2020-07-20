class Merchant < ApplicationRecord
	before_create :create_remember_token
	has_many :merchants
	validates :merchant_name,presence:true,length:{maximum:50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :merchant_email,presence:true,format:{with: VALID_EMAIL_REGEX},
	uniqueness:{case_sensitive: false}
	has_secure_password
	validates :password, length:{minimum: 6}
	# validates :merchant_address,presence:true

	def Merchant.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Merchant.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
	def create_remember_token
		self.remember_token=Merchant.encrypt(Merchant.new_remember_token)
		
	end


end
