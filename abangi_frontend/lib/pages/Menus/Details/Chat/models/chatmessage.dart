class ChatMessage {
  late String name;
  late String message;
  bool isMine = false;

  ChatMessage({required this.name, required this.message, this.isMine = false});
}
