require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
	let(:user) {create :user, confirmed_at: Date.yesterday}
	let(:cart) {create :cart, user: user}
	let(:photo) do
	    Rack::Test::UploadedFile.new(
	      Rails.root.join('spec/images/plant.jpeg'), 'plant.jpeg'
	    )
	  end
	let(:store) {create :store, plant_image: photo}
	let(:cart_item) {create :line_item, cart: cart, store: store}

	before do 
		create :store, plant_image: photo
		create :cart, user: user
	end

	describe "line item" do 
		it "create" do
			sign_in user
			post :create, params: { store_id: store.id }
			expect(response).to redirect_to(cart_path(user.cart))
		end 
	end




end
