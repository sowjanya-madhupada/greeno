require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:admin)        { create :user, :admin, confirmed_at: Date.yesterday }
  let(:user)         { create :user, confirmed_at: Date.yesterday }
  let!(:cart)         { create :cart, user: user}

  context "index" do
    describe "when user is NOT logged in" do
      it "does NOT work" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "when user is logged in" do
      it "does work" do
      	sign_in user
        get :index
        expect(response).to render_template(:index)
      end
    end
  end


  context "create" do
    describe "does not work" do 
    	it "when user or admin not logged in" do
    		post :create
    		expect(response).to redirect_to(new_user_session_path)
        end
    end
    describe "work" do
    	it "when user logged in" do 
    		sign_in user 
    		expect do
    		    post :create, params: {sender_id: user, recipient_id: admin}
    		end.to change(Conversation, :count).by 1
    		expect(response).to redirect_to(conversation_messages_path(Conversation.first))
        end 
    end 
  end
end