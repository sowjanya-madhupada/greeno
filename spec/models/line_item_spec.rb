require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:user) {create :user, confirmed_at: Date.yesterday}
  let(:cart) {create :cart, user: user}
  let(:photo) do
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec/images/plant.jpeg'), 'plant.jpeg'
    )
  end
  let(:store) {create :store, plant_image: photo}
  let(:cart_item) {create :line_item, cart: cart, store: store}

  describe "Total price calculation" do
    it "of item in the cart" do
      result = cart_item.quantity * store.price
      expect(cart_item.total_price).to eq(result)
    end
  end


  describe "line item" do
    it "should belongs to cart" do
      should belong_to(:cart)
    end

    it "should belongs to store" do
      should belong_to(:store)
    end

  end
end
