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

  describe "admin?" do
    it "is user is admin" do 
      user = build :user, :admin
      expect(user).to be_admin 
    end 
    it "user is not admin" do 
      user = build :user
      expect(user).not_to be_admin 
    end
  end


  describe "user" do 
    it "has one cart" do 
      should have_one(:cart)
    end
  end

end
