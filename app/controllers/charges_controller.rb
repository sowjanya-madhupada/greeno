class ChargesController < ApplicationController
	DEFAULT_CURRENCY = 'INR'.freeze

	def new
	end

	def create
		
		@amount = (session[:amount] * 100).to_i
		customer = Stripe::Customer.create(
	      email: params[:stripeEmail],
	      source: params[:stripeToken]
	    )


        charge =  Stripe::Charge.create(
	      customer: customer.id,
	      amount: @amount,
	      currency: DEFAULT_CURRENCY
	    )
    
    rescue Stripe::CardError => e 
    	flash[:alert] = e.message
    	redirect_to new_charge_path
    else
    	CheckoutMailer.purchase(current_cart,current_user).deliver
    	current_cart.line_items.each do |item|
    		item.store.quantity  -=  item.quantity
    		item.store.save
    	end
    	Cart.find(session[:cart_id]).update(purchased_at: Date.today)
    	session[:cart_id] = nil
    end

		


end
