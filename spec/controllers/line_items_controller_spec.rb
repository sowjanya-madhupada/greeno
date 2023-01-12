require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
	let(:user) {create :user, confirmed_at: Date.yesterday}
	let(:cart) {create :cart, user: user}
	let(:photo) do
	    Rack::Test::UploadedFile.new(
	      Rails.root.join('spec/images/plant.jpeg'), 'plant.jpeg'
	    )
	  end
	let!(:store) {create :store, plant_image: photo}
	let!(:line_item) {create :line_item, cart: cart, store: store}

	describe "line item" do 
		it "create" do
			sign_in user
			post :create, params: { store_id: store.id }
			expect(response).to redirect_to(cart_path(user.cart))
		end 
		it "create item when no stock" do
			sign_in user
			store.quantity = 0
			store.save
			post :create, params: { store_id: store.id }
			expect(response).to redirect_to(gallery_index_path)
		end 
	end

	describe "Add Item" do 
		it "To cart" do 
			sign_in user
			expect(LineItem.first.quantity).to eq(3)
			post :add_quantity, params: { id: line_item.id }
			expect(LineItem.first.quantity).to eq(4)
			expect(response).to redirect_to(cart_path(user.cart))
		end 
		it "To cart when no stock available" do 
			sign_in user
			line_item.quantity = store.quantity
            line_item.save
			expect(LineItem.first.quantity).to eq(5)
			post :add_quantity, params: { id: line_item.id }
            expect(LineItem.first.quantity).not_to eq(6)
			expect(response).to redirect_to(cart_path(user.cart))
		end
	end

	describe "Reduce Item" do 
		it "from cart" do 
			sign_in user
			expect(LineItem.first.quantity).to eq(3)
			post :reduce_quantity, params: { id: line_item.id }
			expect(LineItem.first.quantity).to eq(2)
			expect(response).to redirect_to(cart_path(user.cart))
		end 
		it "when it is one" do 
			sign_in user
			line_item.quantity = 1
            line_item.save
			expect(LineItem.first.quantity).to eq(1)
			post :reduce_quantity, params: { id: line_item.id }
            expect(LineItem.first).to be_nil
			expect(response).to redirect_to(cart_path(user.cart))
		end
	end

	describe "#destroy" do 
		it "remove item from cart" do 
            sign_in user
            expect(LineItem.first).not_to be_nil
            get :destroy, params: { id: line_item.id }	
            expect(LineItem.first).to be_nil
            expect(response).to redirect_to(cart_path(user.cart))
        end
    end




end
