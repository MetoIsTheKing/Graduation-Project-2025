class MessageModel {
  final bool isUserMessage;
  final String content;
  final bool isSearchFlights;

  MessageModel({
    required this.isUserMessage,
    required this.content,
    this.isSearchFlights = false,
  });
}
