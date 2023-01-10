require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    let(:store) {build :store}
    it "name cant be blank" do
      store.name = nil
      expect(store).to be_invalid
    end
    it "price cant be blank" do
      store.price = nil
      expect(store).to be_invalid
    end
    it "quantity cant be blank" do
      store.quantity = nil
      expect(store).to be_invalid
    end
    it "plant image cant be blank" do
      store.plant_image = nil
      expect(store).to be_invalid
    end
  end
    
end
