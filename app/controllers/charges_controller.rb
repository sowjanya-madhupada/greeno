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
    	CheckoutMailer.purchase.deliver
    	session[:cart_id] = nil
    	current_user.cart_id = nil
    end

		


end
