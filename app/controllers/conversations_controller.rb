class ConversationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@conversations = Conversation.all 
	end 

	def create 
		if Conversation.between(params[:sender_id],params[:recipient_id]).present? 
			@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first 
		else 
			@conversation = Conversation.create(conversation_params)
			@conversation.cart_id = current_cart.id
			@conversation.save 
		end 
		redirect_to conversation_messages_path(@conversation)
	end 

	private
	def conversation_params
		params.permit(:sender_id, :recipient_id, :cart_id)
	end

end