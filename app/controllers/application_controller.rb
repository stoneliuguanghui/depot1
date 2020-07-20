class ApplicationController < ActionController::Base
	before_action :authorize
	protect_from_forgery
	include MerchantsHelper

	private
	def current_cart
		if Cart.find_by("user_id":current_user.id)!=nil
		   Cart.find_by("user_id":current_user.id)
		else
			if current_user.id!=nil
				cart=current_user.create_cart
				current_user.update "session_id":cart.user_id
				cart
			end
		end
	end
	

	def current_user
		User.find(session[:user_id])
	rescue ActiveRecord::RecordNotFound
		# user=User.create
		# session[:user_id]=user.id
		# user
	end

	protected
	def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to login_path,:notice=>"Please log in"
		end
	end
end
# 用户 商品 订单 购物车 cart_item line_item 商家 关注表 被关注表
# 用户一个购物车多个商品多个订单 用户多个关注表 用户多个被关注表