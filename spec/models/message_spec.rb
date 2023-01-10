require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user1) {create :user, confirmed_at: Date.yesterday}
  let(:user2) {create :user, confirmed_at: Date.yesterday}
  let(:conversation) {create :conversation, sender_id: user1.id, recipient_id: user2.id}
  let(:message) {create :message, user: user1, conversation: conversation}


  describe "Validations" do 
    it "user can't be blank" do
      message.user = nil
      expect(message).to be_invalid
    end  

    it "conversation can't be blank" do
      message.conversation = nil
      expect(message).to be_invalid
    end

    it "body can't be blank" do
      message.body = nil
      expect(message).to be_invalid
    end

    it "passed message created" do
      expect(message).to be_valid
    end
  end


  describe Message do
    it "should belongs_to" do
      message = Message.reflect_on_association(:conversation)
      expect(message.macro).to eq(:belongs_to)
    end

    it "should belongs_to" do
      message = Message.reflect_on_association(:user)
      expect(message.macro).to eq(:belongs_to)
    end
  end
end
