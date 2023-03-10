class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :current_cart
	def check_admin
	    return if current_user && current_user.admin?
	    redirect_to(root_path, flash: { alert: "Sorry, you are not allowed to view that page" })
    end
	
	def after_sign_in_path_for(user)
		flash[:notice]="Login successful. Hi, #{current_user.name}!" 
		root_path
	end
	
	def after_sign_out_path_for(user)
		session[:cart_id] = nil
		flash[:notice]="Logout successful. See you soon!"
		root_path 	
    end

    def current_cart
		begin	
			if current_user
				cart = Cart.find_by(user_id: current_user.id, purchased_at: nil) 
				cart.present? ? session[:cart_id] = cart.id : session[:cart_id] ? cart = Cart.find(session[:cart_id]).update(user_id: current_user.id) : ''				    
			end
			Cart.find(session[:cart_id])
	    rescue ActiveRecord::RecordNotFound
			cart = Cart.create
			if current_user
			   cart.user_id = current_user.id
			   cart.save
			end		
			session[:cart_id] = cart.id
			cart
		end
	end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :phone_number, :password) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :phone_number, :password, :current_password) }
        end
	
end
