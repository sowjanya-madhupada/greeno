class CartsController < ApplicationController
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to @cart, notice: "invalid cart"
    else
      render :show
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    if current_user
      current_user.cart_id = nil
      current_user.save
    end
    redirect_to gallery_index_path, notice: "your cart was successfully deleted"
  end
end
