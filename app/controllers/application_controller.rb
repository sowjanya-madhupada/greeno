class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
    
	def check_admin
	    return if current_user && current_user.admin?
	    redirect_to(root_path, flash: { alert: "Sorry, you are not allowed to view that page" })
    end

    def current_user
	    return unless session[:user_id]

	    @current_user ||= User.find_by(id: session[:user_id])
	end
	
	def after_sign_in_path_for(user)
		flash[:notice]="Login successful. Hi, #{current_user.name}!" 
		root_path
	end
	def after_sign_out_path_for(user)
		flash[:notice]="Logout successful. See you soon!"
		root_path 
    end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :phone_number, :password) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :phone_number, :password, :current_password) }
        end
	
end
