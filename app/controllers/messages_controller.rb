class MessagesController < ApplicationController
	before_action :set_conversation 
	before_action :authenticate_user!

	def index 
		if current_user.id == @conversation.sender_id || current_user.admin?
			@messages = @conversation.messages 
			@message = @conversation.messages.new 
		else
			redirect_to root_path, alert: "you do not have permission for this conversation"
		end

	end 

	def new 
		@message = @conversation.messages.new 
	end 

	def create 
		@message = @conversation.messages.create(message_params)
		if @message.save 
			redirect_to root_path, notice: "Your message successfully sent"
		end 
	end 

	private
	def set_conversation 
		@conversation = Conversation.find(params[:conversation_id])
	end 

	def message_params 
		params.require(:message).permit(:body, :user_id, :conversation_id)
	end 
end