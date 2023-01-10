require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "Associations" do
    it "should have many line items" do
      cart = Cart.reflect_on_association(:line_items)
      expect(cart.macro).to eq(:has_many)
    end

    it "should has one conversation" do
      cart = Cart.reflect_on_association(:conversation)
      expect(cart.macro).to eq(:has_one)
    end

    it "should belongs to user" do
      cart = Cart.reflect_on_association(:user)
      expect(cart.macro).to eq(:belongs_to)
    end

  end
end
