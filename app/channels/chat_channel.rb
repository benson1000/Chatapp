class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_#{params[:chat_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def send_message(data)
    message = current_user.messages.create(content: data['message'], chat_room_id: data['chat_room_id'])
    ActionCable.server.broadcast("chat_#{data['chat_room_id']}", message: render_message(message))
  end

  private

  def render_message(message)
    # Render the message as JSON here, you can include other details like sender name, timestamp, etc.
  end
end
