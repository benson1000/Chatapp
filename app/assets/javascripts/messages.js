
$(document).on('submit', 'form[data-remote="true"]', function(e) {
  e.preventDefault();
  var form = $(this);
  var content = form.find('#message_content').val(); // Use the correct selector for the message content
  var chatRoomId = form.data('chat-room-id');

  App.messages.send_message(content, chatRoomId);
  form[0].reset();
});
