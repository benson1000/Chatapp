class ChatRoom < ApplicationRecord
  has_many :messages
  has_many :user_chat_rooms
  has_many :users, through: :user_chat_rooms
end
