require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe Conversation do
    it "should belongs_to sender" do
      should belong_to(:sender)
    end

    it "should belongs_to recipient" do
      should belong_to(:recipient)
    end

    it "should has many messages" do
      should have_many(:messages)
    end
  end
end
