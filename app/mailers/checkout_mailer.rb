class CheckoutMailer < ApplicationMailer
	def purchase(cart,user)
		@cart = cart
		@user = user
		mail(:to => @user.email, :subject => "Your order has been processed!")
	end
end