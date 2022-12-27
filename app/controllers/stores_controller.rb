class StoresController < ApplicationController
    before_action :check_admin
    before_action :set_store, only: %i[show edit update destroy]
    layout "admin"
    
	def index
		@stores = Store.paginate(page: params[:page], per_page: 10)
	end

	def new
		@store = Store.new
    end  

    def create
        @store = Store.new(store_params)
        if @store.save
        	redirect_to store_path(@store), notice: "#{@store.name} was successfully created "
        else
        	render :new, alert: "Plant was not created please check"
        end
    end

    def update
    	if @store.update(store_params)
    		redirect_to store_path, notice: "Plant details are successfully updated "
        else
        	render :edit, alert: "Plant details are not updated please check"
        end
    end

    def destroy
    	@store.delete
    	redirect_to stores_path, notice: "Plant was successfully deleted"
    end

    private
        def store_params
        	params.require(:store).permit(:name, :price, :season, :plants_type, :quantity, :plant_image)
        end

        def set_store
        	@store = Store.find(params[:id])
        end


end
