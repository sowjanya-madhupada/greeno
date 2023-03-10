require 'rails_helper'

RSpec.describe StoresController, type: :controller do
	let(:user) {create :user, confirmed_at: Date.yesterday}
	let(:admin) {create :user, :admin, confirmed_at: Date.yesterday}
	let(:photo) do
	    Rack::Test::UploadedFile.new(
	      Rails.root.join('spec/images/plant.jpeg'), 'plant.jpeg'
	    )
	  end
	let(:store) {create :store, plant_image: photo}

	describe "store" do 
		it "create when admin" do 
			sign_in admin
			post :create, params: { store: {name: "aloe vera", price: 300, quantity: 2, plant_image: photo}}
		    expect(store).to be_persisted
		end
		it "create when admin" do 
			sign_in user
			post :create, params: { store: {name: "aloe vera", price: 300, quantity: 2, plant_image: photo}}
		    expect(response).to redirect_to(root_path)
		end
	end

	describe "get" do 
        it "index for admin" do 
			sign_in admin
			get :index
			expect(response).to render_template(:index)
		end

		it "index for user" do 
			sign_in user
			get :index
			expect(response).to redirect_to(root_path)
		end


		it "show" do 
	    	sign_in admin
	    	get :new
	    	expect(response).to render_template(:new)
	    end  

	    
	    it "edit" do 
	    	sign_in admin
	    	get :edit, params: {id: store.id}
	    	expect(response).to render_template(:edit)
	    end 
	    
	    it "update store" do 
	    	sign_in admin
	    	patch :update, params: {id: store.id, store: {name: "aloe vera plant", price: 500, quantity: 3} }
	    	expect(response).to redirect_to(store_path)
	    end 

	    it "delete store" do
	        sign_in admin
	        get :destroy, params: {id: store.id}
	        expect(response).to redirect_to(stores_path)
	    end
	end
    

end
