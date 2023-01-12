#frozen_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "cart" do
    it "has many line items" do
      should have_many(:line_items)
    end
    it "belongs to user" do
      should belong_to(:user).optional
    end
    it "has one conversation" do
      should have_one(:conversation)
    end
  end
end
