class SessionsController < ApplicationController
	skip_before_action :authorize
  def new
  end

  def create
  	user=User.find_by(name: session_params[:name])
  	if user&&User.authenticate(session_params[:name],session_params[:password])
  		session[:user_id]=user.id
  		redirect_to admin_url
  	else
  		flash.now[:error] = 'Invalid email/password combination'
			render "new"
  	end
  end

  def destroy
  	session[:user_id]=nil
  	redirect_to store_url,:notice=>"Logged out"
  end
  
  def session_params
  	params.require(:session)
  end

end
