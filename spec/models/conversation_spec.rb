require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe Conversation do
    it "should belongs_to user" do
      conversation = Conversation.reflect_on_association(:sender)
      expect(conversation.macro).to eq(:belongs_to)
    end

    it "should has many messages" do
      conversation = Conversation.reflect_on_association(:messages)
      expect(conversation.macro).to eq(:has_many)
    end
  end
end
