# app/controllers/chat_rooms_controller.rb
class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      ActionCable.server.broadcast("chat_rooms", @chat_room)
      render json: @chat_room, status: :created
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
