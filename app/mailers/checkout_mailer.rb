class CheckoutMailer < ApplicationMailer
	def purchase
		
	  
	    mail(:to => $text.email, :subject => "Your order has been processed!")

    end

end