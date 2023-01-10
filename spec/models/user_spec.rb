require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) {build :user, admin: true}
    it "password should have corect length" do
      user.password = "1"
      expect(user).to be_invalid
    end
    describe "email" do
      it "cant be blank" do
        user.email = nil
        expect(user).to be_invalid
      end
      it "should be in correct format" do
        user.email = "@123.com"
        expect(user).to be_invalid
      end
    end
    it "name cant be blank" do
      user.name = nil
      expect(user).to be_invalid
    end
    describe "phone_number" do
      it "cant be blank" do
        user.phone_number = nil
        expect(user).to be_invalid
      end
      it "must have at least 7 digits" do
        user.phone_number = "947325"
        expect(user).to be_invalid
      end
      it "not have morethan 15 digits" do
        user.phone_number = "3333333333333333"
        expect(user).to be_invalid
      end
    end
  end

  describe "Associations" do 
    it "user has one cart" do 
      user = User.reflect_on_association(:cart)
      expect(user.macro).to eq(:has_one)
    end
  end

end
