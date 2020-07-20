class CartsController < ApplicationController
   skip_before_action :authorize,:only=>[:create,:update,:destroy]

 	
  def index
    byebug
  	@carts=current_cart
  end

  def show
    begin
      byebug
      current_cart
    rescue ActiveRecord::RecordNotFound
      logger.error"Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url,:notice=>'invalid cart'
    else
      respond_to do|format|
        format.html # show.html.erb
        format.xml{render :xml=>@cart}
      end
    end
  end


 
  def create
    @cart = current_user.build_cart
    respond_to do |format|
      if @cart.save
        format.html { redirect_to store_url, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @cart=current_cart
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

end
