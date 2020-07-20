class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  def index

    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 3)
    respond_to do |format|
    	format.html
    	format.xml{render :xml=>@order}
    end
  end


  def show
    order = current_user.orders.find params[:id]
    @line_items=order.line_items
  end


  def new
    @cart=current_cart
    if @cart.line_items.empty?
    	redirect_to store_url,:notice=>"Your cart is empty"
    	return
    end
    @order=Order.new
  end




  def create

    @order = current_user.orders.build(order_params)

    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
      	Cart.find_by("user_id":current_user.id).destroy
        format.html { redirect_to store_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
