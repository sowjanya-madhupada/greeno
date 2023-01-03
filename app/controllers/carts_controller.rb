class CartsController < ApplicationController
  before_action :check_admin, :only => [:index,:cart_list]
  layout "admin", :only => [:index,:cart_list]

  def index
    @carts = Cart.where.not(user_id: nil)
  end

  def cart_list
    @cart = Cart.find(params[:id])
  end

  def show
    begin
      @cart = Cart.find(params[:id])
      redirect_to root_path, alert: "You do not have access for the cart" unless (@cart.id == session[:cart_id] ) 
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "invalid cart"
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to gallery_index_path, notice: "your cart was successfully deleted"
  end
end
