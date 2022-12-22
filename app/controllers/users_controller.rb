class UsersController < ApplicationController
	before_action :set_user, only: %i[show edit update destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
    end

    def update
    	if @user.update(user_params)
    	   redirect_to user_path, notice: "User was successfully updated." 
    	else
           render :edit, notice: "User was not updated please check again."
    	end
    end

    private

	    def user_params
	    	params.require(:user).permit(:name, :emai, :phone_number)
	    end 

	    def set_user
           @user = User.find(params[:id])
        end

end
