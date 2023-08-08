class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat_room = ChatRoom.find_by(id: params[:chat_room_id])
    if chat_room
      stream_for chat_room
    else
      reject # Reject the subscription
    end
  end  

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
