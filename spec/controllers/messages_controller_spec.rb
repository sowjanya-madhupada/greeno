require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
	let(:user) {create :user, confirmed_at: Date.yesterday}
	let(:user1) {create :user, confirmed_at: Date.yesterday}
	let(:admin) {create :user,:admin, confirmed_at: Date.yesterday}
	let(:cart) {create :cart, user: user}
	let(:conversation) {create :conversation, sender: user, recipient: admin}

	describe "get index"  do 
		it "when not logged in" do 
			get :index, params: {conversation_id: conversation} 
			expect(response).to redirect_to(new_user_session_path)
		end
		it "when logged in as user" do 
			sign_in user
			get :index, params: {conversation_id: conversation} 
			expect(response).to render_template(:index)
		end
		it "when logged in as admin" do 
			sign_in admin 
			get :index, params: {conversation_id: conversation}
			expect(response).to render_template(:index)
		end
		it "when logged in as other user1" do
            sign_in user1
			get :index, params: {conversation_id: conversation}
			expect(response).to redirect_to(root_path)
			expect(flash[:alert]).to eq("you do not have permission for this conversation")
	    end
    end

    describe "create message"  do 
		it "when not logged in" do 
			post :create, params: {conversation_id: conversation.id, message: {body: "tseting", user_id: user.id}  }
			expect(response).to redirect_to(new_user_session_path)
			expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
		end
		it "when logged in as user" do 
			sign_in user
			expect do
			    post :create, params: {conversation_id: conversation.id, message: {body: "tseting", user_id: user.id}  }
			end.to change(Message, :count).by 1
			expect(response).to redirect_to(root_path)
			expect(flash[:notice]).to eq("Your message successfully sent")
		end
		it "when logged in as admin" do 
			sign_in admin 
			expect do
			    post :create, params: {conversation_id: conversation.id, message: {body: "tseting", user_id: admin.id}  }
			end.to change(Message, :count).by 1
			expect(response).to redirect_to(root_path)
			expect(flash[:notice]).to eq("Your message successfully sent")
		end
    end	
end