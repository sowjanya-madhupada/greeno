class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
    
	def check_admin
	    return if current_user && current_user.admin?
	    redirect_to(root_path, flash: { alert: "Sorry, you are not allowed to view that page" })
    end
	
	def after_sign_in_path_for(user)
		flash[:notice]="Login successful. Hi, #{current_user.name}!" 
		root_path
	end
	
	def after_sign_out_path_for(user)
		flash[:notice]="Logout successful. See you soon!"
		root_path 
    end

    def current_cart
		begin
			if current_user
			    Cart.find(current_user.cart_id) 
			else
				Cart.find(session[:cart_id])
			end
		rescue ActiveRecord::RecordNotFound
			cart = Cart.create			
			session[:cart_id] = cart.id
			if current_user
				current_user.cart_id = cart.id
				current_user.save
			end
			cart
		end
	end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :phone_number, :password) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :phone_number, :password, :current_password) }
        end
	
end
