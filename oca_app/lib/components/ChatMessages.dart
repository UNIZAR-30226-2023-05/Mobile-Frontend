class ChatMessage {
  String username;
  String messageContent;
  String messageType; // "receiver" o "sender"
  ChatMessage(
      {required this.username,
      required this.messageContent,
      required this.messageType});
}
