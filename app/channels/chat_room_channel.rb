class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    chat_room = ChatRoom.find_by(id: params[:id])
    stream_for chat_room if chat_room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # This method is called when a message is received from the client
    # Implement any necessary logic here (e.g., saving the message to the database)
  end
end
