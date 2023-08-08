// app/assets/javascripts/chat_rooms.js
document.addEventListener("DOMContentLoaded", () => {
    const chatRoomsList = document.getElementById("chat-rooms-list");
    const newChatRoomForm = document.getElementById("new-chat-room-form");
  
    // Fetch available chat rooms and display them
    function fetchChatRooms() {
      fetch("/chat_rooms")
        .then((response) => response.json())
        .then((data) => {
          chatRoomsList.innerHTML = "";
          data.forEach((chatRoom) => {
            const listItem = document.createElement("li");
            listItem.innerHTML = `<a href="/chat_rooms/${chatRoom.id}">${chatRoom.name}</a>`;
            chatRoomsList.appendChild(listItem);
          });
        });
    }
  
    // Create a new chat room
    newChatRoomForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const formData = new FormData(newChatRoomForm);
      fetch("/chat_rooms", {
        method: "POST",
        body: formData,
      }).then(() => {
        newChatRoomForm.reset();
        fetchChatRooms();
      });
    });
  
    // Fetch and display chat rooms on page load
    fetchChatRooms();
});
  


// app/assets/javascripts/chat_room.js
document.addEventListener("DOMContentLoaded", () => {
    const chatMessages = document.getElementById("chat-messages");
    const newMessageForm = document.getElementById("new-message-form");
  
    // Function to display a new message
    function displayMessage(message) {
      const messageDiv = document.createElement("div");
      messageDiv.textContent = `${message.user}: ${message.content}`;
      chatMessages.appendChild(messageDiv);
    }
  
    // Connect to the ActionCable channel for the specific chat room
    if (window.chatRoomId) {
      const cable = ActionCable.createConsumer();
      const chatRoomChannel = cable.subscriptions.create(
        { channel: "ChatRoomChannel", id: window.chatRoomId },
        {
          received: (data) => {
            displayMessage(data);
          },
        }
      );
    }
  
    // Send a new message
    newMessageForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const formData = new FormData(newMessageForm);
      fetch(`/chat_rooms/${window.chatRoomId}/messages`, {
        method: "POST",
        body: formData,
      }).then(() => {
        newMessageForm.reset();
      });
    });
  });
  