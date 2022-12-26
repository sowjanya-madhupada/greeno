class LineItemsController < ApplicationController
	before_action :find_line_item, only: %i[add_quantity reduce_quantity destroy]

	def create
		plant = Store.find(params[:store_id])
		@cart = current_cart
		@line_item = @cart.add_plant(plant.id)
		if @line_item.quantity <= @line_item.store.quantity
			@line_item.save
			redirect_to cart_path(@cart), notice: "#{plant.name} was added to your cart"
		else
			redirect_to gallery_index_path, notice: "Sorry there is no stock for the #{@line_item.store.name}"
		end

	end

	def add_quantity
		if @line_item.quantity < @line_item.store.quantity
			@line_item.quantity += 1 
			@line_item.save 
			redirect_to cart_path(current_cart)
		else
			redirect_to cart_path(current_cart), notice: "Sorry there is no stock for the #{@line_item.store.name}"
		end
	end 

	def reduce_quantity 
		if @line_item.quantity > 1
			@line_item.quantity -= 1
			@line_item.save 
			redirect_to cart_path(current_cart)
		else
           destroy
		end 
    end

	def destroy
		@line_item.destroy
		redirect_to cart_path(current_cart), notice: "plant was successfully removed from the cart"
	end

	private
       def find_line_item
        @line_item = LineItem.find(params[:id])
       end

	   

end
