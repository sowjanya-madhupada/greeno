require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) {create :user, confirmed_at: Date.yesterday}
  let(:admin) {create :user,:admin, confirmed_at: Date.yesterday}
  let(:conversation) {create :conversation, sender: user, recipient: admin}
  let(:message) {create :message, user: user, conversation: conversation}


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
    it "should belongs to conversation" do
      should belong_to(:conversation)
    end

    it "should belongs to user" do
      should belong_to(:user)
    end
  end
end
