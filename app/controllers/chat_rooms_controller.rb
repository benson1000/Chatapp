class ChatRoomsController < ApplicationController

    def send_message
        chat_room = ChatRoom.find(params[:chat_room_id])
        message = current_user.messages.create(content: params[:content], chat_room: chat_room)
        MessagesChannel.broadcast_to(chat_room, message)
    end
end
