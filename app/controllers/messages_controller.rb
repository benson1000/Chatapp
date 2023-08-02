class MessagesController < ApplicationController

    def new
        @message = Message.new
    end

    def create
        @message = Message.new(message_params)
        @message.user = current_user
    
        if @message.save
          ActionCable.server.broadcast 'messages_channel', content: @message.content, username: @message.user.username
          head :ok
        else
          render json: @message.errors, status: :unprocessable_entity
        end
    end

    def index
        # Fetch all messages or messages for a specific chat room if applicable
        @messages = Message.all
    end

    private

    def message_params
        params.require(:message).permit(:content, :chat_room_id)
    end

end
