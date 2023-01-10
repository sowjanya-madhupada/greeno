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


  describe "Associations" do
    it "should belongs to cart" do
      line_item = LineItem.reflect_on_association(:cart)
      expect(line_item.macro).to eq(:belongs_to)
    end

    it "should belongs to store" do
      line_item = LineItem.reflect_on_association(:store)
      expect(line_item.macro).to eq(:belongs_to)
    end

  end
end
